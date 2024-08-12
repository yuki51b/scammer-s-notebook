import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading-modal"
export default class extends Controller {
  static targets = ["loadingModal"]


  show() {
    this.loadingModalTarget.classList.remove('hidden')
  }
}
