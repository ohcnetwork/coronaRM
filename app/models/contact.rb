class Contact < ApplicationRecord
  str_enum sex: [:male, :female]
  str_enum district: [:alappuzha, :ernakulam, :idukki, :kannur, :kasargod, :kollam, :kottayam, :kozhikode, :malappuram, :palakkad, :pathanamthitta, :thiruvananthapuram, :thrissur, :wayanad]
  str_enum risk: [:high, :medium ,:low]
  str_enum tracking_type: [:primary, :secondary, :patient]

  has_many :infectees, class_name: 'Contact', foreign_key: 'infectee_id'
  belongs_to :infector, class_name: 'Contact', optional: true
end
