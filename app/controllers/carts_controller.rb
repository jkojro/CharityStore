class CartsController < ApplicationController
	has_many :items, dependent: :destroy
end
