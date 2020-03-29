import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["add_service", "template"]

  add_association(event) {
    event.preventDefault()
    var content = this.templateTarget.innerHTML.replace(/TEMPLATE_RECORD/g, new Date().valueOf())
    this.add_serviceTarget.insertAdjacentHTML('beforebegin', content)
  }

  remove_association(event) {
    event.preventDefault()
    let service = event.target.closest(".nested-fields")
    service.querySelector("input[name*='_destroy']").value = 1
    service.style.display = 'none'
  }
}