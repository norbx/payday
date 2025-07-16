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

    @key_mapping = nil
    @import ||= ExpensesImport.create!(file_name: @filename)
    @smarter_csv ||= File.open(@csv_file, "r:bom|utf-8") do |f|
      SmarterCSV.process(f, chunk_size: 1000)
    end
  end

  def call
    Expense.transaction do
      @key_mapping = set_key_mapping
      @smarter_csv.each { |chunk| map_and_save_expenses(chunk) }
      @import.update(state: :completed)
    end
  end

  private

  def set_key_mapping
    if mbank_headers?
      MBANK_KEYS
    elsif pkobp_headers?
      PKOBP_KEYS
    else
      raise I18n.t("imports.unsupported_format")
    end
  end

  def map_and_save_expenses(chunk)
    expenses = chunk.map { csv_to_hash(_1) }
    Expense.insert_all(expenses, unique_by: :expenses_unique_index)
  end

  def csv_to_hash(expense)
    subcategory_name = @key_mapping == PKOBP_KEYS ? map_category(expense) : expense[@key_mapping[:category]]
    subcategory = Subcategory.find_by_name(name: subcategory_name)

    {
      date: expense[@key_mapping[:date]],
      description: expense[@key_mapping[:description]].squeeze(" ")|| "Brak opisu",
      amount: expense[@key_mapping[:amount]].to_f,
      category_id: subcategory.category.id,
      subcategory_id: subcategory.id,
      expenses_import_id: @import.id
    }
  end

  def map_category(expense)
    CategoryMapper::PKOBP_KEY_MAPPING[expense[@key_mapping[:category]]]
  end

  def mbank_headers?
    (MBANK_KEYS.values - @smarter_csv.flatten.first.keys).empty?
  end

  def pkobp_headers?
    (PKOBP_KEYS.values - @smarter_csv.flatten.first.keys).empty?
  end
end
