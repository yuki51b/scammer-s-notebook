require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post= build(:post)
  end

  describe "バリデーションチェック" do
    context "失敗パターン" do
      it "titleがない場合に、バリデーションが機能する" do
        @post.title = ""
        @post.valid?
        expect(@post.errors.full_messages).to include("タイトルを入力してください")
      end

      it "titleは255文字以内" do
        @post.title = "a" * 256
        @post.valid?
        expect(@post.errors.full_messages).to include("タイトルは255文字以内で入力してください")
      end

      it "users_scam_nameがない場合に、バリデーションが機能する" do
        @post.users_scam_name = ""
        @post.valid?
        expect(@post.errors.full_messages).to include("詐欺名を入力してください")
      end

      it "users_scam_nameは255文字以内" do
        @post.users_scam_name = "a" * 256
        @post.valid?
        expect(@post.errors.full_messages).to include("詐欺名は255文字以内で入力してください")
      end

      it "bodyがない場合に、バリデーションが機能する" do
        @post.body = ""
        @post.valid?
        expect(@post.errors.full_messages).to include("詐欺被害の詳しい内容を入力してください")
      end

      it "bodyは65535文字以内" do
        @post.body = "a" * 65536
        @post.valid?
        expect(@post.errors.full_messages).to include("詐欺被害の詳しい内容は65535文字以内で入力してください")
      end
    end

    context "成功パターン" do
      it "全ての項目を満たされてバリデーションを通過できる" do
        expect(@post).to be_valid
      end
    end
  end
end
