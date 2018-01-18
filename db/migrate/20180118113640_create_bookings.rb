class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :booking_type
      t.integer :no_of_bookings
      t.references :theatre, index: true, foreign_key: true
      t.references :movie, index: true, foreign_key: true
      t.references :auditorium, index: true, foreign_key: true
      t.references :viewer, index: true, foreign_key: true
      t.references :showtime, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end