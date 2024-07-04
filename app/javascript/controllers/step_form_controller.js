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

  validateCurrentStep() {
    const currentStepElement = this.stepTargets[this.currentStep - 1];
    const radioGroups = currentStepElement.querySelectorAll('input[type="radio"]');
    let isValid = false;

    radioGroups.forEach((radio) => {
      if (radio.checked) {
        isValid = true;
      }
    });

    return isValid;
  }

  nextStep() {
    if (this.validateCurrentStep()) {
      if (this.currentStep < this.stepTargets.length) {
        this.currentStep++;
        this.showCurrentStep();
      }
    } else {
      alert("選択してください");
    }
  }
  
  prevStep() {
    if (this.currentStep > 1) {
      this.currentStep--;
      this.showCurrentStep();
    }
  }
}
