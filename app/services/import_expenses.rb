class ImportExpenses < BaseService
  MBANK_KEYS = {
    date: :data_operacji,
    description: :opis_operacji,
    category: :kategoria,
    amount: :kwota
  }.freeze

  PKOBP_KEYS = {
    date: :data_operacji,
    description: :opis_transakcji,
    category: :rodzaj,
    amount: :kwota
  }.freeze

  def initialize(csv_file, filename)
    @csv_file = csv_file
    @filename = filename
  end

  def call
    Expense.transaction do
      @import ||= ExpensesImport.create!(file_name: @filename)
      @smarter_csv ||= SmarterCSV.process(@csv_file, chunk_size: 1000)

      if mbank_csv?
        @smarter_csv.each do |chunk|
          expenses = chunk.map { mbank_hash(_1) }
          Expense.insert_all(expenses, unique_by: :expenses_unique_index)
        end
      elsif pkobp_csv?
        @smarter_csv.each do |chunk|
          expenses = chunk.map { pkobp_hash(_1) }
          Expense.insert_all(expenses, unique_by: :expenses_unique_index)
        end
      else
        raise I18n.t("imports.unsupported_format")
      end

      @import.update(state: "completed")
    end
  end

  private

  def find_category(name)
    return if name.blank?

    category = Category.find_or_create_by(name: name.strip)
    category.id
  end

  def mbank_hash(expense)
    {
      date: expense[:data_operacji],
      description: expense[:opis_operacji] || "Brak opisu",
      amount: expense[:kwota].to_f,
      category_id: find_category(expense[:kategoria]),
      expenses_import_id: @import.id
    }
  end

  def pkobp_hash(expense)
    {
      date: expense[:data_operacji],
      description: expense[:opis_transakcji] || "Brak opisu",
      amount: expense[:kwota].to_f,
      category_id: find_category(expense[:rodzaj]),
      expenses_import_id: @import.id
    }
  end

  def mbank_csv?
    (MBANK_KEYS.values - @smarter_csv.flatten.first.keys).empty?
  end

  def pkobp_csv?
    (PKOBP_KEYS.values - @smarter_csv.flatten.first.keys).empty?
  end
end
