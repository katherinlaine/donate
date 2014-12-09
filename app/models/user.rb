class User < ActiveRecord::Base
  enum role: [:donor, :agency_admin, :super_admin]

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  belongs_to :agency

  def self.find_agency_admins(agency)
    where(agency_id: agency.id)
  end
end
