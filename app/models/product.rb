class Product < ApplicationRecord
  belongs_to :user
  has_many :checkout
  validates :name, presence: :true
  validates :price, presence: :true
end
