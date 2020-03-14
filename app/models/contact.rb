class Contact < ApplicationRecord
  enum sex: [:male, :female]
  enum district: [:alappuzha, :ernakulam, :idukki, :kannur, :kasargod, :kollam, :kottayam, :kozhikode, :malappuram, :palakkad, :pathanamthitta, :thiruvananthapuram, :thrissur, :wayanad]
  enum risk: [:high, :medium ,:low]
  enum previous_medical: []
  enum symptoms: []

  has_many :secondary_contacts, :class_name => 'Transmission', :foreign_key => 'contact_id'
  has_many :primary_contacts, :class_name => 'Transmission', :foreign_key => 'primary_contact_id' 
end
