class User < ApplicationRecord
  validates :phone_number, presence: true, uniqueness: { case_sensitive: true }
  has_secure_password

  has_many :orders, dependent: :destroy
  belongs_to :subcategory, optional: true

  mount_uploader :avatar, UserAvatarUploader
  mount_base64_uploader :avatar, UserAvatarUploader


  def self.from_token_request(request)
    phone_number = request.params&.[]('auth')&.[]('phone_number')
    find_by phone_number: phone_number
  end
end
