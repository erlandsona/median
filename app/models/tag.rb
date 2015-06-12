class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :posts, through: :taggings

  validates :name, presence: true, format: { without: /[^\w-]/ }, length: { in: 2..50 }




end
