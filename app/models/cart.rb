class Cart < ApplicationRecord
	has_many :items, dependent: :destroy

	def add_product(product)
		current_item = items.find_by(product_id: product.id)
		if current_item
			current_item.quantity += 1
		else
			current_item = items.build(product_id: product.id)
		end
		current_item
	end

	def total_price
		items.to_a.sum {|item| item.total_price}
	end
end
