class Theatre < ActiveRecord::Base
	has_many :movies, dependent: :destroy
	has_many :auditoria, dependent: :destroy
	has_many :viewers, dependent: :destroy
	has_many :bookings, dependent: :destroy
	has_many :seats, dependent: :destroy
	validates :name, presence: true
	validates :address, presence: true
	validates :phone_no, presence: true, length: {in: 8..13}
end