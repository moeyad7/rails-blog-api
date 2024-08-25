class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, dependent: :destroy

  validates :title, :body, :author, presence: true
  validates :tags, presence: true

  # Array of tags, ensuring at least one
  def tags=(value)
    write_attribute(:tags, Array(value).reject(&:blank?))
  end
end
