class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User"

  validates :author, :body, :title, presence: true
end
