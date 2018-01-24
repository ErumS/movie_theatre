class Showtime < ActiveRecord::Base
  belongs_to :movie
  has_many :bookings, dependent: :destroy
  has_many :tickets, dependent: :destroy
  validates :time_of_show, :movie_id, presence: true
end
