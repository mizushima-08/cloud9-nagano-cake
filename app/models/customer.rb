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
  # アカウント作成時の電話番号は10桁もしくは11桁のみ登録可能とするバリデーション
  validates :telephone_number, length: { minimum: 10, maximum: 11 }
  # カタカナ制限
  validates :first_name_kana, :last_name_kana, presence: true, format: { with: /\A([ァ-ン]|ー)+\z/, message: 'はカタカナで入力して下さい。' }
  # アカウント作成時の郵便番号はハイフンなしの7桁のみ登録可能とするバリデーション
  validates :postal_code,
    length: { minimum: 7, maximum: 7 },
    numericality: { only_integer: true }

  # 退会しているとログインできないように
  def active_for_authentication?
    super && self.is_active?
  end
end
