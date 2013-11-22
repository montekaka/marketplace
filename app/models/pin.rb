class Pin < ActiveRecord::Base

	# constants define the category 
	CATEGORY_TYPE = ["Apperal", "Grocery", "Fashion", "Food and Snack", "Baby and Kids", "Craft", "Beauty","Necessities ","Others"]

	belongs_to :user
	
	has_attached_file :image, :styles=>{:medium => "300x300>", :thumb =>"100x100>"}

	validates :category, :inclusion => CATEGORY_TYPE

end
