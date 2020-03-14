class Contact < ApplicationRecord
  enum sex: [:male, :female]
  enum district: [:alappuzha, :ernakulam, :idukki, :kannur, :kasargod, :kollam, :kottayam, :kozhikode, :malappuram, :palakkad, :pathanamthitt, :thiruvananthapuram, :thrissur, :wayanad]
  enum risk: [:high_risk, :low_risk, :no_risk]
  enum previous_medical: []
  enum symptoms: []
end
