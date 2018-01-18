class CreateShowtimes < ActiveRecord::Migration
  def change
    create_table :showtimes do |t|
      t.time :time_of_show
      t.references :movie, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end