class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :posts, through: :taggings

  validates :name,
            presence: true,
            format: {
              without: /[^\w-]/,
              message: "Tags should be separated by commas and should not have special characters"
            },
            length: { in: 2..50 }




end
