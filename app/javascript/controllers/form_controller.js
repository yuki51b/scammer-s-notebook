import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.methodSelectorBox = this.element.querySelector('#method');
    this.contactMethod = this.element.querySelector('#contact_method_text');
    this.contentSelectorBox = this.element.querySelector('#content');
    this.contactContent = this.element.querySelector('#contact_content_text');
    this.informationSelectorBox = this.element.querySelector('#information');
    this.information = this.element.querySelector('#information_text');
    this.paymentSelectorBox = this.element.querySelector('#payment');
    this.payment = this.element.querySelector('#payment_text');

    // 読み込まれたときにformSwitchを呼び出す
    this.method_formSwitch();
    this.content_formSwitch();
    this.information_formSwitch();
    this.payment_formSwitch();

    // ラジオボタンの変更を監視してformSwitchを呼び出す
    this.element.querySelectorAll('.js-check-method').forEach((element) => {
      element.addEventListener('change', () => this.method_formSwitch());
    });
    this.element.querySelectorAll('.js-check-content').forEach((element) => {
      element.addEventListener('change', () => this.content_formSwitch());
    });
    this.element.querySelectorAll('.js-check-information').forEach((element) => {
      element.addEventListener('change', () => this.information_formSwitch());
    });
    this.element.querySelectorAll('.js-check-payment').forEach((element) => {
      element.addEventListener('change', () => this.payment_formSwitch());
    });
  }

  method_formSwitch() {
    let check = this.element.querySelectorAll('.js-check-method');
    if (check.length > 6 && check[6].checked) {  // インデックスの範囲チェック
      this.methodSelectorBox.style.display = 'block';
      this.contactMethod.disabled = false;
    }else{
      this.methodSelectorBox.style.display = 'none';
      this.contactMethod.disabled = true;
      this.contactMethod.value = '';
    }
  }

  content_formSwitch() {
    let check = this.element.querySelectorAll('.js-check-content');
    if (check.length > 9 && check[9].checked) {  // インデックスの範囲チェック
      this.contentSelectorBox.style.display = 'block';
      this.contactContent.disabled = false;
    }else{
      this.contentSelectorBox.style.display = 'none';
      this.contactContent.disabled = true;
      this.contactContent.value = '';
    }
  }

  information_formSwitch() {
    let check = this.element.querySelectorAll('.js-check-information');
    if (check.length > 7 && check[7].checked) { // インデックスの範囲チェック
      this.informationSelectorBox.style.display = 'block';
      this.information.disabled = false;
    }else{
      this.informationSelectorBox.style.display = 'none';
      this.information.disabled = true;
      this.information.value = '';
    }
  }
  payment_formSwitch() {
    let check = this.element.querySelectorAll('.js-check-payment');
    if (check.length > 4 && check[4].checked) { // インデックスの範囲チェック
      this.paymentSelectorBox.style.display = 'block';
      this.payment.disabled = false;
    }else{
      this.paymentSelectorBox.style.display = 'none';
      this.payment.disabled = true;
      this.payment.value = '';
    }
  }
}
