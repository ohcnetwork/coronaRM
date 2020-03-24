class DomesticDetail < ApplicationRecord
  enum mode_of_transport: {train: "train", bus: "bus", private: "private"}
  belongs_to :contact
end
