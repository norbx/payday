module Categories
  class Story
    def initialize(action = Action, printer = Printer.new)
      @action = action
      @printer = printer
    end

    def call
      csv.each do |row|
        printer.print_clear_screen
        printer.print_details(row)
        printer.print_available_categories
        value = printer.prompt_category

        redo unless action.valid_category?(value)

        action.assign_category(row, value)
      end

      csv
    end

    private

    attr_reader :csv, :action, :printer
  end
end