class Symptom < ApplicationRecord
  belongs_to :contact
  enum symptom_type: {}
end
