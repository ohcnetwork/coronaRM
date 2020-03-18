class NonMedicalReq < ApplicationRecord
  enum requirement_type: {food: "food", drinking_water: "drinking_water", household_water: "household_water", sanitary_napkins: "sanitary_napkins", baby_foods: "baby_foods"}
  belongs_to :contact
end
