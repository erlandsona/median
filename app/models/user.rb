class User < ActiveRecord::Base
  authenticates_with_sorcery!
  extend FriendlyId
  friendly_id :username, use: :finders

  has_many :posts, foreign_key: :author_id

  validates :email, :name, :username, presence: true
  validates :name, :username, length: { minimum: 3 }
  validates :email, format: { with: /.+@.+\..+/, message: "must be an email address" }, uniqueness: true
  validates :username, uniqueness: true
  validates :username, format: { with: /\A[a-zA-Z0-9]+\Z/, message: "can't have whitespace or special characters" }
  validates :password, confirmation: true
  validates :password, :password_confirmation, presence: { on: :create }
end
