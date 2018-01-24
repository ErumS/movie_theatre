class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.date :purchase_date
      t.date :movie_date
      t.decimal :price
      t.references :showtime, index: true, foreign_key: true
      t.references :viewer, index: true, foreign_key: true
      t.references :booking, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
