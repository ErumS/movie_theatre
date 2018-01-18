class Auditorium < ActiveRecord::Base
	belongs_to :theatre
	belongs_to :movie
	has_many :viewers, dependent: :destroy
	has_many :bookings, dependent: :destroy
	has_many :seats, dependent: :destroy
	validates :screen_size, presence: true
	validates :no_of_seats, presence: true, inclusion: {in: 1..200}
end