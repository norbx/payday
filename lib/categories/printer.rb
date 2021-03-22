module Categories
  class Printer
    def initialize(prompt = TTY::Prompt.new)
      @prompt = prompt
    end

    def print_details(row)
      prompt.say("Kwota: #{row['Kwota']}")
      prompt.say("Lokalizacja: #{row['Lokalizacja']}")
      prompt.say("Data: #{row['Parsed date']}")
    end

    def print_clear_screen
      system('clear')
    end

    def prompt_available_categories
      prompt.select("Select a category", Category.all, cycle: true, filter: true) do |menu|
        menu.choices.each do |c|
          binding.pry
        end
      end
    end

    def prompt_category
      prompt.ask("Enter category:")
    end

    private

    attr_reader :prompt

    def categories
      @categories ||= Category.pluck(:name).map(&:downcase).join(', ')
    end
  end
end