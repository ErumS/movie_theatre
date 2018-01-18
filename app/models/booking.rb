class Booking < ActiveRecord::Base
	belongs_to :theatre
	belongs_to :movie
	belongs_to :auditorium
	belongs_to :viewer
	belongs_to :showtime
	has_many :tickets, dependent: :destroy
	validates :booking_type, presence: true
	validates :no_of_bookings, presence: true, inclusion: {in: 1..6}
end
