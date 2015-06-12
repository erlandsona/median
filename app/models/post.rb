class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User"

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
end
