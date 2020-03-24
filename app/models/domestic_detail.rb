class DomesticDetail < ApplicationRecord
  enum mode_of_transport: {train: "train", bus: "bus", private_vehicle: "private_vehicle"}
  belongs_to :contact
end
