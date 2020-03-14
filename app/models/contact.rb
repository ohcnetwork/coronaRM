class Contact < ApplicationRecord
  enum sex: [:male, :female]
  enum district: [:alappuzha, :ernakulam, :idukki, :kannur, :kasargod, :kollam, :kottayam, :kozhikode, :malappuram, :palakkad, :pathanamthitt, :thiruvananthapuram, :thrissur, :wayanad]
  enum risk: [:high, :medium ,:low]
  enum previous_medical: []
  enum symptoms: []
end
