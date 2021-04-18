class Categories
  def categorize(&block)
    expenses.each(&block)
  end

  private

  def expenses
    @expenses ||= Expense.where(category: nil)
  end
end
