class Seat < ActiveRecord::Base
  belongs_to :theatre
  belongs_to :viewer
  belongs_to :auditorium
  validates :type_of_seat, :theatre_id, :auditorium_id, :viewer_id, presence: true
end
