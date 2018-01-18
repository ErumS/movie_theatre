class CreateTheatres < ActiveRecord::Migration
  def change
    create_table :theatres do |t|
      t.string :name
      t.text :address
      t.string :phone_no
      t.timestamps null: false
    end
  end
end