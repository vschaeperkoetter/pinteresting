class Pin < ActiveRecord::Base
	belongs_to :user
	has_attached_file :image, :styles => {  :large => "500x500>", 
                          								:medium => "300x300>", 
                          								:thumb => "100x100>" }
	validates :image, presence: true
  validates :description, presence: true
end
