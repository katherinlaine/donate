class ChangeZipcodeToString < ActiveRecord::Migration
  def change
    change_column :agencies, :zipcode, :string
  end
end
