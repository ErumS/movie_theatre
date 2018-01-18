class Movie < ActiveRecord::Base
	belongs_to :theatre
	has_many :auditoria, dependent: :destroy
	has_many :viewers, dependent: :destroy
	has_many :showtimes, dependent: :destroy
	has_many :bookings, dependent: :destroy
	validates :name, presence: true
	validates :rating, presence: true, inclusion: {in: 1..5}
end