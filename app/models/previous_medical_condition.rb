class PreviousMedicalCondition < ApplicationRecord
  enum condition_type: {diabetes: "diabetes", hypertension: "hypertension", cardiac_issues: "cardiac_issues", cholestrol: "cholestrol", kidney_issues: "kidney_issues", stroke: "stroke", tubercolosis: "tubercolosis", others: "others"}
  belongs_to :contact
end
