import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.selecterBox = this.element.querySelector('#sample');
    this.contactContent = this.element.querySelector('#contact_content_text');
    this.formSwitch();  // ページが読み込まれたときに実行

    // ラジオボタンの変更を監視してformSwitchを呼び出す
    this.element.querySelectorAll('.js-check').forEach((element) => {
      element.addEventListener('change', () => this.formSwitch());
    });
  }

  formSwitch() {
    let check = this.element.querySelectorAll('.js-check');
    if (check[9].checked) {
      this.selecterBox.style.display = 'block';
      this.contactContent.disabled = false;
    }else{
      this.selecterBox.style.display = 'none';
      this.contactContent.disabled = true;
      this.contactContent.value = '';
    }
  }
}
