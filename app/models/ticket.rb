class Ticket < ActiveRecord::Base
  belongs_to :viewer
  belongs_to :showtime
  belongs_to :booking
  validates :purchase_date, presence: true
  validates :movie_date, presence: true
  validates :price, :showtime_id, :viewer_id, :booking_id, presence: true
end
