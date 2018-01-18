require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
	context 'Success' do
		
		context 'GET index' do
			it 'should show all tickets successfully' do
				ticket1 = FactoryGirl.create(:ticket)
				ticket2 = FactoryGirl.create(:ticket)
	      get :index, format: 'json'
	      response.should have_http_status(:ok)
	    end
	  end
	  context 'GET show' do
	    it 'should show ticket with given id successfully' do
	      ticket = FactoryGirl.create(:ticket)
	      get :show, id: ticket.id, format: 'json'
	      response.should have_http_status(:ok)
	    end
	  end
		context 'POST create' do
			it 'should create a valid ticket' do
				ticket = FactoryGirl.build(:ticket)
				post :create, ticket: {purchase_date:ticket.purchase_date, movie_date:ticket.movie_date, price:ticket.price, viewer_id:ticket.viewer_id, booking_id:ticket.booking_id},format: 'json'
				response.should have_http_status(:ok)
			end
		end
		context 'PUT update' do
			it 'should update a valid ticket' do
				ticket = FactoryGirl.create(:ticket)
				put :update, id:ticket.id, ticket: {purchase_date:ticket.purchase_date, movie_date:ticket.movie_date, price:240, viewer_id:ticket.viewer_id, booking_id:ticket.booking_id}, format: 'json'
				response.should have_http_status(:ok)
			end
		end
		context 'DELETE destroy' do
			it 'should destroy a valid ticket' do
				ticket = FactoryGirl.create(:ticket)
				delete :destroy, id:ticket.id, format: 'json'
				response.should have_http_status(:ok)
			end
		end
	end

	context'Failure' do

		context 'GET show' do
			it 'should not show a valid ticket' do
				ticket = FactoryGirl.create(:ticket)
        a = Ticket.last
				get :show, id:a.id+1, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
		context 'POST create' do
			it 'should not create a ticket with invalid input' do
				ticket = FactoryGirl.build(:ticket)
				post :create, ticket: {purchase_date:ticket.purchase_date, movie_date:"abc", price:ticket.price},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a ticket with nil entries' do
				ticket = FactoryGirl.build(:ticket)
				post :create, ticket: {purchase_date:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a ticket with invalid viewer_id' do
				ticket = FactoryGirl.build(:ticket)
				post :create, ticket: {viewer_id:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a ticket with invalid booking_id' do
				ticket = FactoryGirl.build(:ticket)
        booking = FactoryGirl.create(:booking)
        a = Booking.last
				post :create, ticket: {booking_id:a.id+1},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
		end
		context 'PUT update' do
			it 'should not update the ticket with invalid id' do
				ticket = FactoryGirl.create(:ticket)
        a = Ticket.last
				put :update, id:a.id+1, ticket: {purchase_date:ticket.purchase_date, movie_date:ticket.movie_date, price:ticket.price}, format: 'json'
				response.should have_http_status(:not_found)
			end	
			it 'should not update the ticket with invalid input' do
				ticket = FactoryGirl.create(:ticket)
				put :update, id:ticket.id, ticket: {purchase_date:ticket.purchase_date, movie_date:nil}, format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end	
			it 'should not update the ticket with invalid viewer id' do
				ticket = FactoryGirl.create(:ticket)
        a = Ticket.last
				put :update, id:a.id+1, ticket: {purchase_date:ticket.purchase_date, movie_date:ticket.movie_date, price:ticket.price, viewer_id:nil}, format: 'json'
				response.should have_http_status(:not_found)
			end
			it 'should not update the ticket with invalid booking id' do
				ticket = FactoryGirl.create(:ticket)
        a = Ticket.last
				put :update, id:a.id+1, ticket: {purchase_date:ticket.purchase_date, movie_date:ticket.movie_date, price:ticket.price, booking_id:nil}, format: 'json'
				response.should have_http_status(:not_found)
			end
		end 
		context 'DELETE destroy' do
			it 'should not destroy the ticket with invalid id' do
				ticket = FactoryGirl.create(:ticket)
        a = Ticket.last
				delete :destroy, id:a.id+1, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
	end
end