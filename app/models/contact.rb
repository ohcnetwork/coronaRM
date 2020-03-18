class Contact < ApplicationRecord
  enum sex: {male: "male", female: "female"}
  enum risk: {high: "high", medium: "medium", low: "low"}
  enum tracking_type: {primary: "primary", secondary: "secondary", patient: "patient"}
  enum isolation_type: {home_isolation: "home_isolation", isolation_ward: "isolation_ward", admitted: "admitted"}

  has_many :infectees, class_name: 'Contact', foreign_key: 'infector_id'
  belongs_to :infector, class_name: 'Contact', optional: true

  has_many :non_medical_reqs
  has_many :medical_reqs
  has_many :previous_medical_conditions
  has_many :symptoms

  has_many :calls
  has_many :callees, through: :calls, source: :user

  belongs_to :district

  def self.to_csv
    attributes = %w{patient_id name tracking_type isolation_type risk non_medical_reqs medical_reqs previous_medical_conditions symptoms phone age gender house_name ward panchayath town district phc_name date_of_first_contact mode_of_contact infector infectees }

    CSV.generate(headers: true) do |csv|
       csv << attributes

      all.each do |contact|
        csv << [
          contact.patient_id,
          contact.name,
          contact.tracking_type, 
          contact.isolation_type, 
          contact.risk,
          contact.non_medical_reqs.pluck(:requirement_type).join(', '),
          contact.medical_reqs.pluck(:requirement_type).join(', '),
          contact.previous_medical_conditions.pluck(:condition_type).join(', '),
          contact.symptoms.pluck(:symptom_type).join(', '),
          contact.phone,
          contact.age,
          contact.gender,
          contact.house_name,
          contact.ward,
          contact.panchayath,
          contact.town,
          contact.district.name,
          contact.phc_name,
          contact.date_of_first_contact,
          contact.mode_of_contact,
          contact.infector.try!(:name),
          contact.infectees.pluck(:name).join(', '),
        ]
      end
    end
  end

end
