class Symptom < ApplicationRecord
  belongs_to :contact
  enum symptom_type: {fever: "fever", cough: "cough", throat_pain: "throat_pain", diarrhoea: "diarrhoea", running_nose: "running_nose"}
end
