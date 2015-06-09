class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :posts, through: :taggings

  validates :name,
            presence: true,
            format: {
              without: /[^\w-]/,
              message: "please enter tag with no whitespace or special characters." 
            },
            length: { in: 2..50 }




end
