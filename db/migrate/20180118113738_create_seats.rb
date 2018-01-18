class CreateSeats < ActiveRecord::Migration
  def change
    create_table :seats do |t|
      t.string :type_of_seat
      t.references :theatre, index: true, foreign_key: true
      t.references :auditorium, index: true, foreign_key: true
      t.references :viewer, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end