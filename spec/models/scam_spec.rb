require 'rails_helper'

RSpec.describe Scam, type: :model do
  before do
    @scam = build(:scam)
  end

  describe 'バリデーションチェック' do
    context '失敗パターン' do
      it 'nameがない場合に、バリデーションが機能する' do
        @scam.name = ''
        @scam.valid?
        expect(@scam.errors.full_messages).to include('詐欺名を入力してください')
      end

      it 'nameは255文字以内' do
        @scam.name = 'a' * 256
        @scam.valid?
        expect(@scam.errors.full_messages).to include('詐欺名は255文字以内で入力してください')
      end

      it 'contentがない場合に、バリデーションが機能する' do
        @scam.content = ''
        @scam.valid?
        expect(@scam.errors.full_messages).to include('詐欺名についての一言を入力してください')
      end

      it 'contentは255文字以内' do
        @scam.content = 'a' * 256
        @scam.valid?
        expect(@scam.errors.full_messages).to include('詐欺名についての一言は255文字以内で入力してください')
      end

      it 'point_1がない場合に、バリデーションが機能する' do
        @scam.point_1 = ''
        @scam.valid?
        expect(@scam.errors.full_messages).to include('詐欺対策ポイント1を入力してください')
      end

      it 'point_1は255文字以内' do
        @scam.point_1 = 'a' * 256
        @scam.valid?
        expect(@scam.errors.full_messages).to include('詐欺対策ポイント1は255文字以内で入力してください')
      end

      it 'point_2がない場合に、バリデーションが機能する' do
        @scam.point_2 = ''
        @scam.valid?
        expect(@scam.errors.full_messages).to include('詐欺対策ポイント2を入力してください')
      end

      it 'point_2は255文字以内' do
        @scam.point_2 = 'a' * 256
        @scam.valid?
        expect(@scam.errors.full_messages).to include('詐欺対策ポイント2は255文字以内で入力してください')
      end

      it 'point_3がない場合に、バリデーションが機能する' do
        @scam.point_3 = ''
        @scam.valid?
        expect(@scam.errors.full_messages).to include('詐欺対策ポイント3を入力してください')
      end

      it 'point_3は255文字以内' do
        @scam.point_3 = 'a' * 256
        @scam.valid?
        expect(@scam.errors.full_messages).to include('詐欺対策ポイント3は255文字以内で入力してください')
      end

      it '詐欺師の手口がない場合に、バリデーションが機能する' do
        @scam.scam_strategy = ''
        @scam.valid?
        expect(@scam.errors.full_messages).to include('詐欺師の手口を入力してください')
      end

      it '詐欺師の手口' do
        @scam.scam_strategy = 'a' * 1001
        @scam.valid?
        expect(@scam.errors.full_messages).to include('詐欺師の手口は1000文字以内で入力してください')
      end
    end

    context '成功パターン' do
      it '全ての項目を満たされてバリデーションを通過できる' do
        expect(@scam).to be_valid
      end
    end
  end
end
