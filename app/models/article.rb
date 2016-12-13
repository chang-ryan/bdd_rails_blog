class Article < ApplicationRecord
  validates :title, :body, presence: true
  
  default_scope { order(created_at: :desc) }
  
  # scope :red, -> { where(color: :red) } 
  #
  # def self.red
  #   where(color: 'red')
  # end
  #
  # http://api.rubyonrails.org/classes/ActiveRecord/Scoping/Named/ClassMethods.html
  
  belongs_to :user
  has_many :comments, dependent: :destroy
end
