class Category < ActiveRecord::Base

  # Gem Friendly ID
  include FriendlyId
  friendly_id :description, use: :slugged

  # Associations
  has_many :ads

  # Validations
  validates_presence_of :description

end
