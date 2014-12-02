class CreateAcceptedFoods < ActiveRecord::Migration
  def change
    create_table :accepted_foods do |t|
      t.belongs_to :food_type
      t.belongs_to :agency
      t.string :quantity
    end
  end
end
