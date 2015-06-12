class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User"

  validates :author, :body, :title, presence: true

  scope :published, -> { where('published_at <= ?', Time.now) }
  scope :unpublished, -> { where('published_at IS NULL') }

  def publish!
    self.published_at = Time.now
    self.save!
  end
end
