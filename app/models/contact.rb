class Contact < ApplicationRecord
  enum sex: [:male, :female]
  enum district: [:alappuzha, :ernakulam, :idukki, :kannur, :kasargod, :kollam, :kottayam, :kozhikode, :malappuram, :palakkad, :pathanamthitta, :thiruvananthapuram, :thrissur, :wayanad]
  enum risk: [:high, :medium ,:low]
  enum tracking_type: [:primary, :secondary, :patient]
  enum previous_medical: []
  enum symptoms: []

  has_many :infectees, class_name: 'Contact', foreign_key: 'infector_id'
  belongs_to :infector, class_name: 'Contact', optional: true

  has_many :non_medical_reqs, inverse_of: :contact
  accepts_nested_attributes_for :non_medical_reqs
end
