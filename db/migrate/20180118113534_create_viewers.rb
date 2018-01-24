class CreateViewers < ActiveRecord::Migration
  def change
    create_table :viewers do |t|
      t.string :name
      t.string :phone_no
      t.string :mode_of_payment
      t.references :theatre, index: true, foreign_key: true
      t.references :movie, index: true, foreign_key: true
      t.references :auditorium, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
