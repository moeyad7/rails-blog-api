class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, foreign_key: 'user_id', dependent: :destroy

  validates :image, presence: true, format: { with: /\A(http|https):\/\/[\S]+\z/, message: "must be a valid URL" }

  def jwt_payload
    super
  end
end