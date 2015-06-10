class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  def normalize_friendly_id(string)
    super.gsub("-", "_")
  end

  belongs_to :author, class_name: "User"

  validates :author, :body, :title, presence: true
end
