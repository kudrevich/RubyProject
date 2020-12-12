class Order < ApplicationRecord
  belongs_to :user
  belongs_to :subcategory
  belongs_to :executor, class_name: "User", optional: true

  mount_uploader :picture, OrderPictureUploader
  mount_base64_uploader :picture, OrderPictureUploader
  
end
