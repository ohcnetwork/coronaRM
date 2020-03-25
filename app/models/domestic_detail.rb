class DomesticDetail < ApplicationRecord
  enum mode_of_transport: {train: "train", bus: "bus", private_vehicle: "private_vehicle", domestic_flight: "domestic_flight"}
  belongs_to :contact
end
