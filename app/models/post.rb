class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  mount_uploader :image, ImageUploader

  belongs_to :author, class_name: "User"
  validates :author, :body, :title, presence: true

  def normalize_friendly_id(title)
    super.gsub("-", "_")
  end
end
