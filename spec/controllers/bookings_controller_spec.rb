require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
	context 'Success' do
		
		context 'GET index' do
			it 'should show all bookings successfully' do
	      get :index, format: 'json'
	      response.should have_http_status(:ok)
	    end
	  end
	  context 'GET show' do
	    it 'should show booking with given id successfully' do
	      booking = FactoryGirl.create(:booking)
	      get :show, id:booking.id, format: 'json'
	      response.should have_http_status(:ok)
	    end
	  end
		context 'POST create' do
			it 'should create a valid booking' do
				booking = FactoryGirl.create(:booking)
				post :create, booking: {booking_type:booking.booking_type, no_of_bookings:booking.no_of_bookings, theatre_id:booking.theatre_id, viewer_id:booking.viewer_id},format: 'json'
				response.should have_http_status(:ok)
			end
		end
		context 'PUT update' do
			it 'should update a valid booking' do
				booking = FactoryGirl.create(:booking)
				put :update, id:booking.id, booking: {booking_type:"middle", no_of_bookings:booking.no_of_bookings, theatre_id:booking.theatre_id, viewer_id:booking.viewer_id}, format: 'json'
				response.should have_http_status(:ok)
			end
		end
		context 'DELETE destroy' do
			it 'should destroy a valid booking' do
				booking = FactoryGirl.create(:booking)
				delete :destroy, id:booking.id, format: 'json'
				response.should have_http_status(:ok)
			end
		end
	end

	context'Failure' do

		context 'GET show' do
			it 'should not show a valid booking' do
				booking = FactoryGirl.create(:booking)
				get :show, id:33, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
		context 'POST create' do
			it 'should not create a booking with invalid input' do
				booking = FactoryGirl.create(:booking)
				post :create, booking: {booking_type:booking.booking_type, no_of_bookings:40, theatre_id:booking.theatre_id, viewer_id:booking.viewer_id},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a booking with nil entries' do
				booking = FactoryGirl.create(:booking)
				post :create, booking: {booking_type:nil, theatre_id:booking.theatre_id, viewer_id:booking.viewer_id},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a booking with invalid theatre_id' do
				booking = FactoryGirl.create(:booking)
				post :create, booking: {booking_type:nil, theatre_id:678, viewer_id:booking.viewer_id},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a booking with invalid viewer_id' do
				booking = FactoryGirl.create(:booking)
				post :create, booking: {booking_type:nil, theatre_id:booking.theatre_id, viewer_id:2337},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
		end
		context 'PUT update' do
			it 'should not update the booking with invalid id' do
				booking = FactoryGirl.create(:booking)
				put :update, id:111, booking: {booking_type:booking.booking_type, no_of_bookings:booking.no_of_bookings}, format: 'json'
				response.should have_http_status(:not_found)
			end	
			it 'should not update the booking with invalid input' do
				booking = FactoryGirl.create(:booking)
				put :update, id:booking.id, booking: {booking_type:booking.booking_type, no_of_bookings:nil}, format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end	
			it 'should not update the booking with invalid theatre id' do
				booking = FactoryGirl.create(:booking)
				put :update, id:1111, booking: {booking_type:booking.booking_type, no_of_bookings:booking.no_of_bookings, theatre_id:nil}, format: 'json'
				response.should have_http_status(:not_found)
			end
			it 'should not update the booking with invalid viewer id' do
				booking = FactoryGirl.create(:booking)
				put :update, id:111, booking: {booking_type:booking.booking_type, no_of_bookings:booking.no_of_bookings, viewer_id:nil}, format: 'json'
				response.should have_http_status(:not_found)
			end
		end 
		context 'DELETE destroy' do
			it 'should not destroy the booking with invalid id' do
				booking = FactoryGirl.create(:booking)
				delete :destroy, id:123, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
	end
end