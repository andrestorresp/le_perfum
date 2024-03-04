class Product < ApplicationRecord
  belongs_to :user
  has_many :checkout
  has_one_attached :photo
  
  include PgSearch::Model
  pg_search_scope :perfum_search,
  against: [ :name, :description ],
  using: {
    tsearch: { prefix: true }
  }
  validates :name, presence: :true
  validates :description, presence: :true
  validates :price, presence: :true
end
