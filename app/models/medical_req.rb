class MedicalReq < ApplicationRecord
  enum requirement_type: {food: "food", drinking_water: "drinking_water"}
  belongs_to :contact
end
