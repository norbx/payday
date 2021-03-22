prompt = TTY::Prompt.new

# file_path = prompt.ask('Enter a csv spreadsheet path:', convert: :filepath)
file_path = 'wydatki.csv'
csv = Preprocessor.new(Reader.read_csv(file_path)).extract_dates

loop do
  system('clear')

  action = prompt.select('What would you like to do?') do |menu|
    menu.choice 'Import expenses', 1
    menu.choice 'Create a report', 2
    menu.choice 'Visualize expenses', 3, disabled: '(Available soon)'
    menu.choice 'Exit', 4
  end

  case action
  when 1
    Importer.new(csv).import
    prompt.say("\nCSV successfully imported.", color: :bright_cyan)
    prompt.keypress('Press any key to continue..')
  when 2
    # Categories::Story.new(csv).call
    prompt.select("Select a category", Category.all, cycle: true, filter: true) do |menu|
      binding.pry
    end
  when 4
    exit
  end
end
