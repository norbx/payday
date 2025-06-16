class ImportExpenses < BaseService
  EXPENSE_KEYS = [
    :data_operacji,
    :opis_operacji,
    :kategoria,
    :kwota
  ]

  def initialize(csv_file, filename)
    @csv_file = csv_file
    @filename = filename
  end

  def call
    Expense.transaction do
      @import ||= ExpensesImport.create!(file_name: @filename)

      SmarterCSV.process(@csv_file, chunk_size: 1000) do |chunk|
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

      @import.update(state: "completed")
    end
  end

  private

  def find_category(name)
    category = Category.find_or_create_by(name: name.strip)
    category.id
  end
end
