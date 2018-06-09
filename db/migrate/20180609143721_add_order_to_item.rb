class AddOrderToItem < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :order, foreign_key: true
  end
end
