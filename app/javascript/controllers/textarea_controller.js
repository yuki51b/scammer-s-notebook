import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["textarea"]

  connect() {
    this.adjustHeight()
    this.resize()
  }

  adjustHeight() {
    const textarea = this.textareaTarget
    textarea.style.height = 'auto'
    textarea.style.height = `${textarea.scrollHeight}px`
  }

  resize() {
    const textarea = this.textareaTarget
    if (textarea.offsetHeight > textarea.scrollHeight) {
      textarea.style.height = '1px'
    }
    while (textarea.offsetHeight < textarea.scrollHeight) {
      textarea.style.height = `${textarea.offsetHeight + 1}px`
    }
  }
}
