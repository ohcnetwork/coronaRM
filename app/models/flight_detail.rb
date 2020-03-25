class FlightDetail < ApplicationRecord
  before_save :default_values

  belongs_to :contact

  def default_values
    self.is_notified_country ||= true
  end
end
