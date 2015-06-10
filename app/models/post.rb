class Post < ActiveRecord::Base
  attr_accessor :image
  mount_uploader :image, ImageUploader
  belongs_to :author, class_name: "User"
  validates :author, :body, :title, presence: true
end