class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :author, class_name: "User"

  validates :author, :body, presence: true
end
