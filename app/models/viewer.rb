class Viewer < ActiveRecord::Base
	belongs_to :theatre
	belongs_to :movie
	belongs_to :auditorium
	has_many :bookings, dependent: :destroy
	has_many :tickets, dependent: :destroy
	has_many :seats, dependent: :destroy
	validates :name, presence: true
	validates :phone_no, presence: true, length: {in: 8..15}
end