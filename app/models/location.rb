class Location < ApplicationRecord
  geocoded_by :address

  validates_uniqueness_of :address

  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
end
