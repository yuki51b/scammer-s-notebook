import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="view-chat"
export default class extends Controller {
  static targets = ["viewChat"]
  connect() {
    this.viewChatTarget.style.display = 'none';
    this.messages = [
      "僕の手帳を見るかい？",
      "詐欺に気をつけて！",
      "今日もお疲れ様です",
      "詐欺って身近なんだぜ!",
      "いつも頑張るあなたは偉い!",
      "詐欺師に注意だぞ!",
      "勉強頑張ってくれよな!",
      "ニット帽可愛いだろ!",
      "あなたは頑張っている!",
      "怪しいと感じたら立ち止まるんだぞ",
      "焦る必要なんて全くない",
      "一旦冷静になって!",
      "ふっふっふっふ",
      "自分を責めないで!",
      "落ち込むこともあるもんさ!",
      "あなたは十分素敵です!",
      "君の人生は無駄じゃないよ"
    ];
  }

  preview() {
    this.viewChatTarget.style.display = 'block';
    // 一旦アニメーションのクラスを削除
    this.viewChatTarget.classList.remove("animate-fade-out")

    // ランダムな文章を選ぶ
    const randomMessage = this.messages[Math.floor(Math.random() * this.messages.length)];

    // 選ばれた文章をチャットバブルに表示
    this.viewChatTarget.textContent = randomMessage;

    // 次のフレームで再度アニメーションクラスを追加
    requestAnimationFrame(() => {
      this.viewChatTarget.classList.add("animate-fade-out")
    })
  }
}
