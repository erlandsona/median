class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  has_many :taggings
  has_many :tags, through: :taggings

  validates :author, :body, :title, presence: true

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
        Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end

end
