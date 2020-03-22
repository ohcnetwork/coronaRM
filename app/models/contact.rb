class Contact < ApplicationRecord
  enum gender: {male: "male", female: "female"}
  enum risk: {high: "high", medium: "medium", low: "low"}
  enum tracking_type: {primary: "primary", secondary: "secondary", patient: "patient", flight_passenger: "flight_passenger"}
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
  has_one :flight_detail

  def self.to_csv
    attributes = %w{id patient_id name tracking_type isolation_type risk non_medical_reqs non_medical_other medical_reqs medical_other previous_medical_conditions symptoms feedback_comment phone age gender house_name ward panchayath town district phc_name date_of_first_contact mode_of_contact infector infectees date_of_arrival flight_number arrival_airport departure_country profession is_health_worker connecting_flight_details}

    CSV.generate(headers: true) do |csv|
       csv << attributes

      all.each do |contact|
        contact_rows = [
          contact.id,
          contact.patient_id,
          contact.name,
          contact.tracking_type, 
          contact.isolation_type, 
          contact.risk,
          contact.non_medical_reqs.pluck(:requirement_type).join(', '),
          contact.non_med_other,
          contact.medical_reqs.pluck(:requirement_type).join(', '),
          contact.med_other,
          contact.previous_medical_conditions.pluck(:condition_type).join(', '),
          contact.symptoms.pluck(:symptom_type).join(', '),
          contact.comment,
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

        if contact.tracking_type == "flight_passenger" and contact.flight_detail
          contact_rows = contact_rows + [
            contact.flight_detail.date_of_arrival,
            contact.flight_detail.flight_number,
            contact.flight_detail.arrival_airport,
            ISO3166::Country[contact.flight_detail.departure_country].try(:name),
            contact.flight_detail.profession,
            contact.flight_detail.is_health_worker,
            contact.flight_detail.connecting_flight_details
          ]
        end
        csv << contact_rows
      end
    end
  end

end
