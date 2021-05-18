class Printer
  def initialize
    @prompt = TTY::Prompt.new
    @theme = :cyan
  end

  def main_menu
    prompt.select('What would you like to do?') do |menu|
      menu.choice 'Import expenses', 1
      menu.choice 'Categorize', 2
      menu.choice 'Create report', 3
      menu.choice 'Visualize expenses', 4
      menu.choice 'Exit', 5
    end
  end

  def divider
    prompt.say("\n")
    prompt.say('=' * 100, color: theme)
    prompt.say("\n\n")
  end

  def print_expense(expense)
    print `clear`
    prompt.say 'Transaction date: '.send(theme) + expense.transaction_date.to_s
    prompt.say 'Amount: '.send(theme) + expense.amount.to_s
    prompt.say 'Localization: '.send(theme) + expense.localization.to_s
    prompt.say 'Description: '.send(theme) + expense.description.to_s
  end

  def prompt_date(message)
    prompt.ask(message).chomp.to_date
  rescue Date::Error
    retry
  end

  def file_path
    prompt.ask('Enter a csv spreadsheet path:', convert: :filepath)
  end

  def successful_import(row_count)
    prompt.say("\nCSV successfully imported #{row_count} rows", color: :bright_cyan)
    prompt.keypress('Press any key to continue..')
  end

  def successful_report
    prompt.say("\nReport successfully created", color: :bright_cyan)
    prompt.keypress('Press any key to continue..')
  end

  def select_category
    prompt.select('Select category', per_page: 100, filter: true, cycle: true, active_color: theme) do |menu|
      Category.all.each { |category| menu.choice category.name.capitalize, category }
    end
  end

  def plots
    loop do
      print `clear`
      option = prompt.select('Choose plot', cycle: true, active_color: theme) do |menu|
        menu.choice 'Daily plot', -> { Plots::Daily.call }
        menu.choice 'Return to previous menu', 9
      end
      break if option == 9
    end
  end

  private

  attr_reader :prompt, :theme
end
