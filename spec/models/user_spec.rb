require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context 'ユーザー情報が登録できない場合' do
      it 'ニックネームが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'メールアドレスが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'メールアドレスが一意性でないと登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'メールアドレスが@を含まないと登録できない' do
        @user.email = '@'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'パスワードが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードが6文字以下だと登録できない' do
        @user.password = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it 'パスワードが半角英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it 'パスワードに半角数字のみでは登録できない' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it 'パスワードに全角文字を含むと登録できない' do
        @user.password = 'あいうえお'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end


      it 'パスワードとパスワード(確認)が一致していないと登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      
    end

    context 'ユーザー情報が登録できる場合' do
      it 'パスワードが6文字以上、英数字混合であれば登録できる' do
        @user.password = 'a12345'
        @user.password_confirmation = 'a12345'
        expect(@user).to be_valid
      end

      describe '本人情報登録' do
        context '本人情報が登録できない場合' do
          it 'お名前(全角)に名字がないと登録できない' do
            @user.family_name = ''
            @user.first_name = '陸太郎'
            @user.valid?
            expect(@user.errors.full_messages).to include("Family name can't be blank")
          end

          it 'お名前(全角)に名前がないと登録できない' do
            @user.family_name = '山田'
            @user.first_name = ''
            @user.valid?
            expect(@user.errors.full_messages).to include("First name can't be blank")
          end

          it 'お名前カナ(全角)に名字がないと登録できない' do
            @user.family_name = ''
            @user.first_name = 'リクタロウ'
            @user.valid?
            expect(@user.errors.full_messages).to include("Family name can't be blank")
          end

          it 'お名前カナ(全角)名前がないと登録できない' do
            @user.family_name = 'ヤマダ'
            @user.first_name = ''
            @user.valid?
            expect(@user.errors.full_messages).to include("First name can't be blank")
          end

          it '名字は全角（漢字・ひらがな・カタカナ）でないと登録できない' do
            @user.family_name = '2222'
            @user.first_name = '陸太郎'
            @user.valid?
            expect(@user.errors.full_messages).to include('Family name is invalid')
          end

          it '名前は全角（漢字・ひらがな・カタカナ）でないと登録できない' do
            @user.family_name = '山田'
            @user.first_name = '2222'
            @user.valid?
            expect(@user.errors.full_messages).to include('First name is invalid')
          end

          it '名字のフリガナは全角（カタカナ）でないと登録できない' do
            @user.family_name_kana = '山田'
            @user.first_name_kana = 'リクタロウ'
            @user.valid?
            expect(@user.errors.full_messages).to include('Family name kana is invalid')
          end

          it '名前のフリガナは全角（カタカナ）でないと入力できない' do
            @user.family_name_kana = 'ヤマダ'
            @user.first_name_kana = '陸太郎'
            @user.valid?
            expect(@user.errors.full_messages).to include('First name kana is invalid')
          end

          it '生年月日がないと登録できない' do
            @user.birthday = ''
            @user.valid?
            expect(@user.errors.full_messages).to include("Birthday can't be blank")
          end

          context '本人情報が登録できる場合' do
            it 'お名前が全角(漢字・ひらがな・カタカナ)ならば登録できる' do
              @user.family_name = '山田'
              @user.first_name = '陸太郎'
              expect(@user).to be_valid
            end

            it 'お名前カナが全角カタカナであれば登録できる' do
              @user.family_name = 'ヤマダ'
              @user.first_name = 'リクタロウ'
              expect(@user).to be_valid
            end
          end
        end
      end
    end
  end
end
