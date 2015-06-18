class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  mount_uploader :image, ImageUploader

  belongs_to :author, class_name: "User"
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :comments

  validate :all_tags_are_valid
  validates :author, :body, :title, presence: true

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create
    end
  end

  def all_tags
    self.tags.pluck(:name).join(", ")
  end

  private

  def all_tags_are_valid
    errors.add(:all_tags, "Can't contain special characters") unless tags.all? {|t| t.valid? }
  end

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
