class Subcategory < ApplicationRecord
  belongs_to :category
  has_many :orders, dependent: :destroy
  has_many :users
end
