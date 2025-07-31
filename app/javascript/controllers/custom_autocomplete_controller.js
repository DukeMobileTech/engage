import Autocomplete from "stimulus-autocomplete"

export default class extends Autocomplete {
  connect() {
    super.connect()
    this.resultsContainer = document.querySelector("#autocomplete-results")
  }

  replaceResults(results) {
    results = JSON.parse(results)
    this.resultsContainer.innerHTML = ""

    if (!results.length) {
      this.resultsContainer.textContent = "No potential duplicates with that name"
      return
    }

    const ul = document.createElement("ul")
    ul.classList.add("autocomplete-results")

    results.forEach(item => {
      const li = document.createElement("li")
      li.textContent = item.name

      li.addEventListener("click", (e) => {
        e.preventDefault()
        window.location.href = `/participants/${item.id}`
      })

      ul.appendChild(li)
    })

    this.resultsContainer.appendChild(ul)
  }

  select(item) {
    
  }
}
