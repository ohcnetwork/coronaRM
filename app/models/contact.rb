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
    attributes = %w{id email name}

    CSV.generate(headers: true) do |csv|
      # csv << attributes
      csv << column_names


      all.each do |user|
        # csv << attributes.map{ |attr| user.send(attr) }
        csv << result.attributes.values_at(*column_names)
      end
    end
  end

end
