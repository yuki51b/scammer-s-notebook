require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    # 各テストコードが実行される前にFactoryBotで生成したインスタンスを@userに代入
    @user = build(:user)
  end

  describe 'バリデーションチェック' do
    context '失敗パターン' do
      it 'nameがない場合に、バリデーションが機能する' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名前を入力してください')
      end

      it 'nameは255文字以下' do
        @user.name = 'a' * 256
        @user.valid?
        expect(@user.errors.full_messages).to include('名前は255文字以内で入力してください')
      end

      it 'emailがない場合に、バリデーションが機能する' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスを入力してください')
      end

      it '@マークがemailの登録にない場合に、バリデーションが機能する' do
        @user.email.slice!('@')
        @user.valid?
      end

      it '同じemailは登録ができない' do
        @user.save
        another_user = build(:user)
        another_user.email = @user.email
        another_user.valid?
      end

      it 'パスワードがない場合にバリデーションが機能する' do
        @user.password = ''
        @user.valid?
      end

      it 'パスワードは６文字以上でないといけない' do
        @user.password = 'a' * 5
        @user.valid?
      end

      it '確認用のパスワードがない場合に、バリデーションが機能する' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード(もう一度)とパスワードの入力が一致しません', 'パスワード(もう一度)を入力してください')
      end

      it '確認用のパスワードは、入力されたパスワードと同じでないといけない。' do
        @user.password = 'password'
        @user.password_confirmation = '12345678'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード(もう一度)とパスワードの入力が一致しません')
      end
    end

    context '成功パターン' do
      it '条件が満たされてバリデーションに通過できる' do
        expect(@user).to be_valid
      end
    end
  end
end
