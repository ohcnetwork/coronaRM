class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:phone_caller, :admin, :medical_officer, :officer, :state_official]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :phone_caller
  end

  has_many :calls
  has_many :called, through: :calls, source: :contact
end
