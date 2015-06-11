class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  has_many :taggings
  has_many :tags, through: :taggings

  # attr_reader :all_tags

  validates :author, :body, :title, presence: true
  validates_associated :tags, message: "Tags should be separated by commas and should not have special characters"

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
        Tag.where(name: name.strip).first_or_create
    end
    self.errors.messages[:all_tags] = self.errors.messages[:tags]
    # @all_tags = self.tags.map(&:name).join(", ")
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end

end
