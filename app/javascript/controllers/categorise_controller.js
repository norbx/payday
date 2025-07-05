import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["expense", "progress", "form"]
  static values = { expenses: Array, categories: Array }

  connect() {
    this.index = 0
    this.expenses = this.expensesValue
    this.categories = this.categoriesValue

    // Load saved assignments if any
    this.assignments = JSON.parse(localStorage.getItem("expenseAssignments") || "{}")

    // Resume from first uncategorized expense
    this.index = this.expenses.findIndex(e => !this.assignments[e.id]) || 0

    this.showCurrentExpense()
  }

   showCurrentExpense() {
    const current = this.expenses[this.index]
    if (!current) {
      this.progressTarget.innerText = `All ${this.expenses.length} expenses categorised.`
      return
    }

    this.expenseTarget.innerHTML = `
      <div class="p-4 border rounded shadow-sm bg-white">
        <h3 class="text-lg font-medium">${current.description}</h3>
        <p class="text-gray-700">${current.amount} zł z dnia ${current.date}</p>
        <div class="mt-4 space-x-2">
          ${this.categories.map(cat => `
            <button
              type="button"
              class="bg-blue-500 hover:bg-blue-600 text-black px-3 py-1 rounded text-sm"
              data-categorise-category-id-param="${cat.id}"
              data-action="click->categorise#selectCategory"
            >
              ${cat.name}
            </button>
          `).join("")}
        </div>
      </div>
    `

    this.progressTarget.innerText = `Kategoryzujesz ${this.index + 1} z ${this.expenses.length} wydatków`
  }

  selectCategory(event) {
    const current = this.expenses[this.index]
    if (current) {
      this.assignments[current.id] = event.params.categoryId
      localStorage.setItem("expenseAssignments", JSON.stringify(this.assignments))
      this.index++
      this.showCurrentExpense()
    }
  }

  submit(event) {
    const input = document.createElement("input")
    input.type = "hidden"
    input.name = "expenses"
    input.value = JSON.stringify(
      Object.entries(this.assignments).map(([id, category_id]) => ({ id, category_id }))
    )
    this.formTarget.appendChild(input)

    localStorage.removeItem("expenseAssignments")
  }
}
