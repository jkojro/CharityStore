class Cart < ApplicationRecord
	has_many :items, dependent: :destroy
end
