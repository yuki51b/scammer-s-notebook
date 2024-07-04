import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["step"]

  connect() {
    this.currentStep = 1; // 初期ステップを1に設定
    this.showCurrentStep();
  }

  showCurrentStep() {
    this.stepTargets.forEach((stepElement, index) => {
      if (index === this.currentStep - 1) {
        stepElement.style.display = "block"; // 現在のステップを表示
      } else {
        stepElement.style.display = "none"; // それ以外のステップを非表示
      }
    });
  }

  nextStep() {
    if (this.currentStep < this.stepTargets.length) {
      this.currentStep++;
      this.showCurrentStep();
    }
  }

  prevStep() {
    if (this.currentStep > 1) {
      this.currentStep--;
      this.showCurrentStep();
    }
  }
}
