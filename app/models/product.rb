class Product < ApplicationRecord
	validates :title, :description, presence: true
	validates :price, numericality: { greater_than_or_equal_to: 0.01 }
	validates :title, uniqueness: true
	belongs_to :user
	has_many :items
	before_destroy :ensure_not_referenced_by_any_item

	private

	# ensure that there are no line items referencing this product
	def ensure_not_referenced_by_any_item
		unless items.empty?
			errors.add(:base, 'Na stanie są sztuki tego produktu')
			throw :abort
		end
	end
end
