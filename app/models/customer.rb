class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  # アカウント作成時の電話番号はハイフンなしの10桁もしくは11桁のみ登録可能とするバリデーショ
  validates :telephone_number, format: { with: /\A\d{10,11}\z/ }
  # カタカナ制限
  validates :first_name_kana, :last_name_kana, presence: true, format: { with: /\A([ァ-ン]|ー)+\z/, message: 'はカタカナで入力して下さい。' }
  # アカウント作成時の郵便番号はハイフンなしの7桁のみ登録可能とするバリデーション
  validates :postal_code, format: { with: /\A\d{7}\z/ }
end
