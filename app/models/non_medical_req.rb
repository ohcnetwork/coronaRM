class NonMedicalReq < ApplicationRecord
  belongs_to :contact

  enum requirement_type: [:food, :water, :sanitary_napkins]
end
