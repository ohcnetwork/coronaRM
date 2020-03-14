class Transmission < ApplicationRecord
  belongs_to :contact
  belongs_to :primary_contact, :class_name => 'Contact'
end
