class Order < ApplicationRecord
	has_many :items, dependent: :destroy

	enum foundation: {
		"Fundacja Dziecięca Fantazja"			=>0,
		"Miłosnicy zwierząt pomagają"			=>1,
		"Ratujmy Puszczę"						=>2,
		"Pomoc Polakom poza Polską"				=>4,
		"Wspieram młodych programistów"			=>5,
		"Ruby on Rails is coming foundation"	=>6
	}
	
    validates :name, :address, :email, presence: true
	validates :foundation, inclusion: foundations.keys


	def add_items_from_cart(cart)
		cart.items.each do |item|
			item.cart_id = nil
			items << item
		end
	end
end
