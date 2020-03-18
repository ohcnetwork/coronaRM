class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: {phone_caller: "phone_caller", admin: "admin", medical_officer: "medical_officer", officer: "officer", state_official: "state_official"}
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :phone_caller
  end

  has_many :calls
  has_many :called, through: :calls, source: :contact

  belongs_to :district, optional: true
end
