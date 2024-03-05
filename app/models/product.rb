class Product < ApplicationRecord
  belongs_to :user
  has_many :checkouts
  has_many :reviews
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :perfum_search,
  against: [ :name, :description ],
  using: {
    tsearch: { prefix: true }
  }
  validates :name, presence: :true
  validates :name, length: { maximum: 25 }
  validates :description, presence: :true
  validates :price, presence: :true
  validates :description, length: { minimum: 6 }
  validates :description, length: { maximum: 148 }
end
