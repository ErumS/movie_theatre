class RenameBookingAttribute < ActiveRecord::Migration
  def change
    rename_column :bookings, :booking_type, :booking_category
  end
end
