class Product < ApplicationRecord
  belongs_to :category
  validates :title, :description, :price, presence: true
end