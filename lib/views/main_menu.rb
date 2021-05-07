printer = Printer.new

loop do
  system('clear')

  action = printer.main_menu

  case action
  when 1
    csv = Preprocessor.new(Reader.read_csv(printer.file_path)).extract_dates
    row_count = Importer.new(csv).import
    printer.successful_import(row_count)
  when 2
    Categories.new.categorize do |expense|
      printer.print_expense(expense)
      printer.divider

      category = printer.select_category

      expense.update!(category: category)
    end
  when 3
    payday = printer.prompt_date('Please enter payday date:')
    Reports.new(payday: payday).call
    printer.successful_report
  when 4
    exit
  end
end
