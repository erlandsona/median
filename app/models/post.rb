class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  mount_uploader :image, ImageUploader

  belongs_to :author, class_name: "User"
  has_many :comments

  validates :author, :body, :title, presence: true

  scope :published, -> { where('published_at <= ?', Time.now) }
  scope :unpublished, -> { where('published_at IS NULL') }

  def publish!
    self.published_at = Time.now
    self.save!
  end

  def draft?
    self.published_at.nil?
  end

  def title_with_status
    if self.draft?
      self.title = "#{title} [DRAFT]"
    else
      self.title = "#{title}"
    end
  end

  def normalize_friendly_id(title)
    super.gsub("-", "_")
  end
end
