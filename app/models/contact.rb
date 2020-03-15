class Contact < ApplicationRecord
  enum sex: [:male, :female]
  enum district: [:alappuzha, :ernakulam, :idukki, :kannur, :kasargod, :kollam, :kottayam, :kozhikode, :malappuram, :palakkad, :pathanamthitta, :thiruvananthapuram, :thrissur, :wayanad]
  enum risk: [:high, :medium ,:low]
  enum tracking_type: [:primary, :secondary, :patient]
  enum previous_medical: []
  enum symptoms: []
end
