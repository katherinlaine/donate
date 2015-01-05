class User < ActiveRecord::Base
  enum role: [:donor, :agency_admin, :super_admin]

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  belongs_to :agency

  def self.find_agency_admins(agency)
    where(agency_id: agency.id)
  end

  def make_agency_admin
    self.role = "agency_admin"
  end

  def has_rights_to_edit(agency)
    self.agency_id == agency.id && self.agency_admin?
  end
end
