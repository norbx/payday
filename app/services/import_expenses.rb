class ImportExpenses < BaseService
  MBANK_KEYS = {
    date: "#data_operacji".to_sym,
    description: "#opis_operacji".to_sym,
    category: "#kategoria".to_sym,
    amount: "#kwota".to_sym
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

  def mbank_hash(expense)
    subcategory = Subcategory.find_by_name(name: expense[MBANK_KEYS[:category]])

    {
      date: expense[MBANK_KEYS[:date]],
      description: expense[MBANK_KEYS[:description]].squeeze(" ")|| "Brak opisu",
      amount: expense[MBANK_KEYS[:amount]].to_f,
      category_id: subcategory.category.id,
      subcategory_id: subcategory.id,
      expenses_import_id: @import.id
    }
  end

  def pkobp_hash(expense)
    mapped_name = CategoryMapper::PKOBP_KEY_MAPPING[expense[PKOBP_KEYS[:category]]]
    subcategory = Subcategory.find_by_name(name: mapped_name)

    {
      date: expense[:data_operacji],
      description: expense[:opis_transakcji] || "Brak opisu",
      amount: expense[:kwota].to_f,
      category_id: subcategory.category.id,
      subcategory_id: subcategory.id,
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
