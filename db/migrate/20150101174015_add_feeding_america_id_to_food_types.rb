class AddFeedingAmericaIdToFoodTypes < ActiveRecord::Migration
  def change
    add_column :food_types, :feeding_america_id, :string
  end
end
