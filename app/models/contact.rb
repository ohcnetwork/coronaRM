class Contact < ApplicationRecord
  enum gender: {male: "male", female: "female"}
  enum risk: {high: "high", medium: "medium", low: "low"}
  enum tracking_type: {primary: "primary", secondary: "secondary", patient: "patient"}
  enum passenger_type: {flight_passenger: "flight_passenger", domestic_passenger: "domestic_passenger"}
  enum isolation_type: {home_isolation: "home_isolation", isolation_ward: "isolation_ward", admitted: "admitted"}

  attr_accessor :name_and_id

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
  has_one :domestic_detail


  def name_and_id
    "ID: #{id}, #{name}"
  end

  def self.to_minimal_csv
    attributes = %w{id name phone tracking_type passenger_type isolation_type profession is_health_worker house_name ward panchayath}

    CSV.generate(headers: true) do |csv|
       csv << attributes

      all.each do |contact|
        contact_rows = [
          contact.id,
          contact.name,
          contact.phone,
          contact.tracking_type,
          contact.passenger_type,
          contact.isolation_type,
          contact.profession,
          contact.is_health_worker,
          contact.house_name,
          contact.ward,
          contact.panchayath
        ]

        csv << contact_rows
      end
    end
  end

  def self.to_csv
    attributes = %w{id patient_id name tracking_type passenger_type isolation_type risk did_meet_suspected_patient non_medical_reqs non_medical_other medical_reqs medical_other previous_medical_conditions symptoms feedback_comment profession is_health_worker phone age gender house_name ward panchayath town district phc_name date_of_first_contact mode_of_contact infector infectees date_of_arrival flight_number arrival_airport departure_country is_notified_country connecting_flight_details mode_of_transport domestic_date_of_arrival place_of_departure transport_detail}

    CSV.generate(headers: true) do |csv|
       csv << attributes

      all.each do |contact|
        contact_rows = [
          contact.id,
          contact.patient_id,
          contact.name,
          contact.tracking_type, 
          contact.passenger_type, 
          contact.isolation_type, 
          contact.risk,
          contact.did_meet_suspected_patient,
          contact.non_medical_reqs.pluck(:requirement_type).join(', '),
          contact.non_med_other,
          contact.medical_reqs.pluck(:requirement_type).join(', '),
          contact.med_other,
          contact.previous_medical_conditions.pluck(:condition_type).join(', '),
          contact.symptoms.pluck(:symptom_type).join(', '),
          contact.comment,
          contact.profession,
          contact.is_health_worker,
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

        if contact.passenger_type == "flight_passenger" and contact.flight_detail
          contact_rows = contact_rows + [
            contact.flight_detail.date_of_arrival,
            contact.flight_detail.flight_number,
            contact.flight_detail.arrival_airport,
            ISO3166::Country[contact.flight_detail.departure_country].try(:name),
            contact.flight_detail.is_notified_country,
            contact.flight_detail.connecting_flight_details
          ]
        else
          contact_rows = contact_rows + [
            "",
            "",
            "",
            "",
            "",
            ""
          ]
        end
        if contact.passenger_type == "domestic_passenger" and contact.domestic_detail
          contact_rows = contact_rows + [
            contact.domestic_detail.mode_of_transport,
            contact.domestic_detail.date_of_arrival,
            contact.domestic_detail.place_of_departure,
            contact.domestic_detail.transport_detail,
          ]
        end
        csv << contact_rows
      end
    end
  end

end
