class Trip < ApplicationRecord
  validates :start_address, presence: true
  validates :start_address, format: { with: /.{3,}\, .{3,}\, .{3,}/,
    message: "address should be given as street (plus number), city, country separated by commas" }
  validates :destination_address, presence: true
  validates :destination_address, format: { with: /.{3,}\, .{3,}\, .{3,}/,
    message: "address should be given as street (plus number), city, country separated by commas" }
  validates :price, presence: true
  validates :price, comparison: { greater_than_or_equal_to: 0, message: "price cannot be negative" }
  validates :date, presence: true
  validates :date, format: { with: /\d{4}\-\d{2}\-\d{2}/ , message: "date should be in format YYYY-MM-DD" }
  validates :distance, comparison: { greater_than_or_equal_to: 0, message: "distance cannot be negative" }, allow_nil: true
end
