class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  has_many :taggings
  has_many :tags, through: :taggings

  validate :all_tags_are_valid
  validates :author, :body, :title, presence: true

  def all_tags=(names)
    names.split(",").map do |name|
      self.tags << Tag.where(name: name.strip).first_or_create
    end
  end

  def all_tags
    self.tags.pluck(:name).join(", ")
  end

  private

  def all_tags_are_valid
    errors.add(:all_tags, "Can't contain special characters") unless tags.all? {|t| t.valid? }
  end

end
