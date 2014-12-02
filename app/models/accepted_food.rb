class AcceptedFood < ActiveRecord::Base
  belongs_to :agency
  belongs_to :food_type
end
