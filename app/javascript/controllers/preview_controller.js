import { Controller } from "@hotwired/stimulus"
import { marked } from "marked"

export default class extends Controller {
  static targets = ["textarea", "previewArea", "previewButton", "editButton"]

  connect() {
    this.editButtonTarget.style.display = 'none'
    this.previewAreaTarget.style.display = 'none'
  }

  preview() {
    const markdownText = this.textareaTarget.value
    const html = marked(markdownText)
    this.previewAreaTarget.innerHTML = html

    this.textareaTarget.style.display = 'none'
    this.previewButtonTarget.style.display = 'none'
    this.editButtonTarget.style.display = 'inline-block'
    this.previewAreaTarget.style.display = 'block'
  }

  edit() {
    this.textareaTarget.style.display = 'block'
    this.previewButtonTarget.style.display = 'inline-block'
    this.editButtonTarget.style.display = 'none'
    this.previewAreaTarget.style.display = 'none'
  }
}
