class CreateAuditoria < ActiveRecord::Migration
  def change
    create_table :auditoria do |t|
      t.string :screen_size
      t.integer :no_of_seats
      t.references :theatre, index: true, foreign_key: true
      t.references :movie, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end