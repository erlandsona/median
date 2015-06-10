class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :author, class_name: "User"

  default_scope { order('created_at DESC') }

  validates :author, :body, presence: true
end
