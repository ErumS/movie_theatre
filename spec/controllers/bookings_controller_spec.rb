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
        movie = FactoryGirl.create(:movie)
        viewer = FactoryGirl.create(:viewer) 
				post :create, booking: { booking_category:"lower", no_of_bookings:4, viewer_id:viewer.id, movie_id:movie.id },format: 'json'
				response.should have_http_status(:ok)
			end
		end
		context 'PUT update' do
			it 'should update a valid booking' do
				booking = FactoryGirl.create(:booking)
				put :update, id:booking.id, booking: {booking_category:"middle", no_of_bookings:booking.no_of_bookings, theatre_id:booking.theatre_id, viewer_id:booking.viewer_id}, format: 'json'
				new_booking = Booking.last
        new_booking.booking_category.should eq "middle"
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
        new_booking = Booking.last
				get :show, id:new_booking.id+1, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
		context 'POST create' do
			it 'should not create a booking with invalid input' do
				post :create, booking: { no_of_bookings:40 },format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a booking with nil entries' do
				post :create, booking: { booking_category:nil },format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a booking with invalid theatre_id' do
        theatre = FactoryGirl.create(:theatre)
        theatre.destroy
				post :create, booking: { theatre_id:theatre.id },format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a booking with invalid viewer_id' do
        viewer = FactoryGirl.create(:viewer)
        viewer.destroy
				post :create, booking: { viewer_id:viewer.id },format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
		end
		context 'PUT update' do
			it 'should not update the booking with invalid id' do
				booking = FactoryGirl.create(:booking)
        new_booking = Booking.last
				put :update, id:new_booking.id+1, booking: {booking_category:booking.booking_category, no_of_bookings:booking.no_of_bookings}, format: 'json'
				response.should have_http_status(:not_found)
			end	
			it 'should not update the booking with invalid input' do
				booking = FactoryGirl.create(:booking)
				put :update, id:booking.id, booking: {booking_category:booking.booking_category, no_of_bookings:nil}, format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end	
			it 'should not update the booking with invalid theatre id' do
				booking = FactoryGirl.create(:booking)
        new_booking = Booking.last
				put :update, id:new_booking.id+1, booking: {booking_category:booking.booking_category, no_of_bookings:booking.no_of_bookings, theatre_id:nil}, format: 'json'
				response.should have_http_status(:not_found)
			end
			it 'should not update the booking with invalid viewer id' do
				booking = FactoryGirl.create(:booking)
        new_booking = Booking.last
				put :update, id:new_booking.id+1, booking: {booking_category:booking.booking_category, no_of_bookings:booking.no_of_bookings, viewer_id:nil}, format: 'json'
				response.should have_http_status(:not_found)
			end
		end 
		context 'DELETE destroy' do
			it 'should not destroy the booking with invalid id' do
				booking = FactoryGirl.create(:booking)
        new_booking = Booking.last
				delete :destroy, id:new_booking.id+1, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
	end
end