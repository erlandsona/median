class User < ActiveRecord::Base
  authenticates_with_sorcery!
  extend FriendlyId
  friendly_id :username, use: [:slugged, :finders]

  has_many :posts, foreign_key: :author_id

  validates :email, :name, :username, presence: true
  validates :name, :username, length: { minimum: 3 }
  validates :email, format: { with: /.+@.+\..+/, message: "must be an email address" }, uniqueness: true
  #validates :username, uniqueness: true
  validates_uniqueness_of :username, case_sensitive: false
  validates :password, confirmation: true
  validates :password, :password_confirmation, presence: { on: :create }
end
