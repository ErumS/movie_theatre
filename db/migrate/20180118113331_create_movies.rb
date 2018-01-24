class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.integer :rating
      t.string :cast
      t.integer :duration
      t.references :theatre, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
