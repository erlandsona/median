class Image < ActiveRecord::Base
  belongs_to :posts
  mount_uploader :image, ImageUploader
end
