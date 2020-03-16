class Contact < ApplicationRecord
  enum sex: {male: "male", female: "female"}
  enum risk: {high: "high", medium: "medium", low: "low"}
  enum tracking_type: {primary: "primary", secondary: "secondary", patient: "patient"}
  enum isolation_type: {home_isolation: "home_isolation", isolation_ward: "isolation_ward", admitted: "admitted"}

  DISTRICTS_IN_KERALA = %w[alappuzha ernakulam idukki kannur kasargod kollam kottayam kozhikode malappuram palakkad pathanamthitta thiruvananthapuram thrissur wayanad].freeze
  enum district: DISTRICTS_IN_KERALA.zip(DISTRICTS_IN_KERALA).to_h

  has_many :infectees, class_name: 'Contact', foreign_key: 'infector_id'
  belongs_to :infector, class_name: 'Contact', optional: true
end
