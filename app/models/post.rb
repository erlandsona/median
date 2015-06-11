class Post < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :author, class_name: "User"
  validates :author, :body, :title, presence: true
end
