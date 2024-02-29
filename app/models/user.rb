class User < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :checkout
  has_one_attached :photo
  validates :name, presence: :true
  validates :last_name, presence: :true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
