
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_180_120_110_928) do
  create_table 'auditoria', force: :cascade do |t|
    t.string   'screen_size', limit: 255
    t.integer  'no_of_seats', limit: 4
    t.integer  'theatre_id',  limit: 4
    t.integer  'movie_id',    limit: 4
    t.datetime 'created_at',              null: false
    t.datetime 'updated_at',              null: false
  end

  add_index 'auditoria', ['movie_id'], name: 'index_auditoria_on_movie_id', using: :btree
  add_index 'auditoria', ['theatre_id'], name: 'index_auditoria_on_theatre_id', using: :btree

  create_table 'bookings', force: :cascade do |t|
    t.string   'booking_category', limit: 255
    t.integer  'no_of_bookings',   limit: 4
    t.integer  'theatre_id',       limit: 4
    t.integer  'movie_id',         limit: 4
    t.integer  'auditorium_id',    limit: 4
    t.integer  'viewer_id',        limit: 4
    t.integer  'showtime_id',      limit: 4
    t.datetime 'created_at',                   null: false
    t.datetime 'updated_at',                   null: false
  end

  add_index 'bookings', ['auditorium_id'], name: 'index_bookings_on_auditorium_id', using: :btree
  add_index 'bookings', ['movie_id'], name: 'index_bookings_on_movie_id', using: :btree
  add_index 'bookings', ['showtime_id'], name: 'index_bookings_on_showtime_id', using: :btree
  add_index 'bookings', ['theatre_id'], name: 'index_bookings_on_theatre_id', using: :btree
  add_index 'bookings', ['viewer_id'], name: 'index_bookings_on_viewer_id', using: :btree

  create_table 'movies', force: :cascade do |t|
    t.string   'name',       limit: 255
    t.integer  'rating',     limit: 4
    t.string   'cast',       limit: 255
    t.integer  'duration',   limit: 4
    t.integer  'theatre_id', limit: 4
    t.datetime 'created_at',             null: false
    t.datetime 'updated_at',             null: false
  end

  add_index 'movies', ['theatre_id'], name: 'index_movies_on_theatre_id', using: :btree

  create_table 'seats', force: :cascade do |t|
    t.string   'type_of_seat',  limit: 255
    t.integer  'theatre_id',    limit: 4
    t.integer  'auditorium_id', limit: 4
    t.integer  'viewer_id',     limit: 4
    t.datetime 'created_at',                null: false
    t.datetime 'updated_at',                null: false
  end

  add_index 'seats', ['auditorium_id'], name: 'index_seats_on_auditorium_id', using: :btree
  add_index 'seats', ['theatre_id'], name: 'index_seats_on_theatre_id', using: :btree
  add_index 'seats', ['viewer_id'], name: 'index_seats_on_viewer_id', using: :btree

  create_table 'showtimes', force: :cascade do |t|
    t.time     'time_of_show'
    t.integer  'movie_id', limit: 4
    t.datetime 'created_at',             null: false
    t.datetime 'updated_at',             null: false
  end

  add_index 'showtimes', ['movie_id'], name: 'index_showtimes_on_movie_id', using: :btree

  create_table 'theatres', force: :cascade do |t|
    t.string   'name',       limit: 255
    t.text     'address',    limit: 65_535
    t.string   'phone_no',   limit: 255
    t.datetime 'created_at',               null: false
    t.datetime 'updated_at',               null: false
  end

  create_table 'tickets', force: :cascade do |t|
    t.date     'purchase_date'
    t.date     'movie_date'
    t.decimal  'price', precision: 10
    t.integer  'showtime_id',   limit: 4
    t.integer  'viewer_id',     limit: 4
    t.integer  'booking_id',    limit: 4
    t.datetime 'created_at',                             null: false
    t.datetime 'updated_at',                             null: false
  end

  add_index 'tickets', ['booking_id'], name: 'index_tickets_on_booking_id', using: :btree
  add_index 'tickets', ['showtime_id'], name: 'index_tickets_on_showtime_id', using: :btree
  add_index 'tickets', ['viewer_id'], name: 'index_tickets_on_viewer_id', using: :btree

  create_table 'viewers', force: :cascade do |t|
    t.string   'name',            limit: 255
    t.string   'phone_no',        limit: 255
    t.string   'mode_of_payment', limit: 255
    t.integer  'theatre_id',      limit: 4
    t.integer  'movie_id',        limit: 4
    t.integer  'auditorium_id',   limit: 4
    t.datetime 'created_at',                  null: false
    t.datetime 'updated_at',                  null: false
  end

  add_index 'viewers', ['auditorium_id'], name: 'index_viewers_on_auditorium_id', using: :btree
  add_index 'viewers', ['movie_id'], name: 'index_viewers_on_movie_id', using: :btree
  add_index 'viewers', ['theatre_id'], name: 'index_viewers_on_theatre_id', using: :btree

  add_foreign_key 'auditoria', 'movies'
  add_foreign_key 'auditoria', 'theatres'
  add_foreign_key 'bookings', 'auditoria'
  add_foreign_key 'bookings', 'movies'
  add_foreign_key 'bookings', 'showtimes'
  add_foreign_key 'bookings', 'theatres'
  add_foreign_key 'bookings', 'viewers'
  add_foreign_key 'movies', 'theatres'
  add_foreign_key 'seats', 'auditoria'
  add_foreign_key 'seats', 'theatres'
  add_foreign_key 'seats', 'viewers'
  add_foreign_key 'showtimes', 'movies'
  add_foreign_key 'tickets', 'bookings'
  add_foreign_key 'tickets', 'showtimes'
  add_foreign_key 'tickets', 'viewers'
  add_foreign_key 'viewers', 'auditoria'
  add_foreign_key 'viewers', 'movies'
  add_foreign_key 'viewers', 'theatres'
end
