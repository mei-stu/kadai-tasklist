class User < ApplicationRecord
  # バリデーション
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    # format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    format: { with: /\A[\w\+\-\.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    # 重複禁止: { 大文字小文字の区別なし }
                    uniqueness: { case_sensitive: false }
  
  # パスワードダイジェスト
  has_secure_password
  
  # 一対多( UserからTaskをみたとき、複数存在する  )
  has_many :tasks
end
