require 'rails_helper'

RSpec.describe BuyAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @buy_address = FactoryBot.build(:buy_address, user_id: @user.id, item_id: @item.id)
    sleep 0.1
  end

  describe '商品購入情報の保存' do
    context '問題があり保存できない場合' do
      it '郵便番号がないと保存できない' do
        @buy_address.post_code = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Post code can't be blank")
      end

      it '郵便番号が三桁ハイフン四桁の半角文字列でないと保存できない' do
        @buy_address.post_code = 1_112_222
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end

      it '発送元がないと保存できない' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村がないと保存できない' do
        @buy_address.city = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("City can't be blank")
      end

      it '番地がないと保存できない' do
        @buy_address.address = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号がないと保存できない' do
        @buy_address.telephone = ''
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Telephone can't be blank")
      end

      it '電話番号は9桁以下だと保存できない' do
        @buy_address.telephone = '12345'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('Telephone is too short (minimum is 10 characters)')
      end

      it '電話番号は12桁以上だと保存できない' do
        @buy_address.telephone = '12345678901234'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('Telephone is too long (maximum is 11 characters)')
      end

      it '電話番号はハイフンを含むと保存できない' do
        @buy_address.telephone = '090-1234-5678'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('Telephone is invalid. not hyphen')
      end

      it '電話番号に全角文字を含むと登録できない' do
        @buy_address.telephone = 'あいうえお'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('Telephone is not a number')
      end

      it 'userが紐付いていないと保存できない' do
        @buy_address.user_id = nil
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていないと保存できない' do
        @buy_address.item_id = nil
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Item can't be blank")
      end

      it 'tokenが空では登録できないこと' do
        @buy_address.token = nil
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include("Token can't be blank")
      end
    end

    context '正常に保存できる場合' do
      it '全ての情報が正しく入力されていれば保存できる' do
        expect(@buy_address).to be_valid
      end

      it '建物名は入力しなくても保存できる' do
        @buy_address.building = ''
        expect(@buy_address).to be_valid
      end
    end
  end
end
