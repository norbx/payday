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

      if (MBANK_KEYS.values - @smarter_csv.first.first.keys).empty?
        @smarter_csv.each do |chunk|
          Expense.insert_all(
            chunk.map do |expense|
              {
                date: expense[:data_operacji],
                description: expense[:opis_operacji],
                amount: expense[:kwota].to_f,
                category_id: find_category(expense[:kategoria]),
                expenses_import_id: @import.id
              }
            end
          )
        end
      elsif (PKOBP_KEYS.values - @smarter_csv.first.first.keys).empty?
        @smarter_csv.each do |chunk|
          Expense.insert_all(
            chunk.map do |expense|
              {
                date: expense[:data_operacji],
                description: expense[:opis_operacji],
                amount: expense[:kwota].to_f,
                category_id: find_category(expense[:rodzaj]),
                expenses_import_id: @import.id
              }
            end
          )
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
end
