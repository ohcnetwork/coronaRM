class PreviousMedicalCondition < ApplicationRecord
  enum condition_type: {diabetes: "diabetes"}
  belongs_to :contact
end
