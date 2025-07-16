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
      @smarter_csv ||= File.open(@csv_file, "r:bom|utf-8") do |f|
        SmarterCSV.process(f, chunk_size: 1000)
      end

      if mbank_csv?
        @smarter_csv.each do |chunk|
          expenses = chunk.map { csv_to_hash(_1, MBANK_KEYS) }
          Expense.insert_all(expenses, unique_by: :expenses_unique_index)
        end
      elsif pkobp_csv?
        @smarter_csv.each do |chunk|
          expenses = chunk.map { csv_to_hash(_1, PKOBP_KEYS) }
          Expense.insert_all(expenses, unique_by: :expenses_unique_index)
        end
      else
        raise I18n.t("imports.unsupported_format")
      end

      @import.update(state: "completed")
    end
  end

  private

  def csv_to_hash(expense, key_mapping)
    subcategory_name = key_mapping == PKOBP_KEYS ? map_category(expense, key_mapping) : expense[key_mapping[:category]]
    subcategory = Subcategory.find_by_name(name: subcategory_name)

    {
      date: expense[key_mapping[:date]],
      description: expense[key_mapping[:description]].squeeze(" ")|| "Brak opisu",
      amount: expense[key_mapping[:amount]].to_f,
      category_id: subcategory.category.id,
      subcategory_id: subcategory.id,
      expenses_import_id: @import.id
    }
  end

  def map_category(expense, key_mapping)
    CategoryMapper::PKOBP_KEY_MAPPING[expense[key_mapping[:category]]]
  end

  def mbank_csv?
    (MBANK_KEYS.values - @smarter_csv.flatten.first.keys).empty?
  end

  def pkobp_csv?
    (PKOBP_KEYS.values - @smarter_csv.flatten.first.keys).empty?
  end
end
