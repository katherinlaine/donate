class CreateAgencies < ActiveRecord::Migration
  def change
    create_table :agencies do |t|
      t.text :name
      t.string :contact
      t.string :phone
      t.text :address
      t.text :city
      t.integer :zipcode
      t.text :notes

      t.timestamps
    end
  end
end
