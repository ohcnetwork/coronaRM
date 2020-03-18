class MedicalReq < ApplicationRecord
  enum requirement_type: {need_medicines: "need_medicines", ongoing_dialysis: "ongoing_dialysis", ongoing_cancer_chemo_radio_therapy: "ongoing_cancer_chemo_radio_therapy"}
  belongs_to :contact
end
