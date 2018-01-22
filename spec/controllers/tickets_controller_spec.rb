require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  context 'Success' do
    context 'GET index' do
      it 'should show all tickets successfully' do
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
        showtime = FactoryGirl.create(:showtime)
        viewer = FactoryGirl.create(:viewer)
        booking = FactoryGirl.create(:booking)
        post :create, ticket: { purchase_date: '01-02-2016', movie_date: '01-03-2016', price: 125, showtime_id: showtime.id, viewer_id: viewer.id, booking_id: booking.id }, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'PUT update' do
      it 'should update a valid ticket' do
        ticket = FactoryGirl.create(:ticket)
        put :update, id: ticket.id, ticket: { purchase_date: ticket.purchase_date, movie_date: "01-02-2017", price: 240, viewer_id: ticket.viewer_id, booking_id: ticket.booking_id }, format: 'json'
        new_ticket = Ticket.last
        new_ticket.movie_date.strftime("%d-%m-%Y").should eq "01-02-2017"
        new_ticket.price.should eq 240
        response.should have_http_status(:ok)
      end
    end
    context 'DELETE destroy' do
      it 'should destroy a valid ticket' do
        ticket = FactoryGirl.create(:ticket)
        delete :destroy, id: ticket.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
  end

  context 'Failure' do
    context 'GET show' do
      it 'should not show a valid ticket' do
        ticket = FactoryGirl.create(:ticket)
        new_ticket = Ticket.last
        get :show, id: new_ticket.id + 1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'POST create' do
      it 'should not create a ticket with invalid input' do
        post :create, ticket: { movie_date: 'abc' }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a ticket with nil entries' do
        post :create, ticket: { purchase_date: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a ticket with invalid viewer_id' do
        post :create, ticket: { viewer_id: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a ticket with invalid booking_id' do
        booking = FactoryGirl.create(:booking)
        new_booking = Booking.last
        post :create, ticket: { booking_id: new_booking.id + 1 }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
    end
    context 'PUT update' do
      it 'should not update the ticket with invalid id' do
        ticket = FactoryGirl.create(:ticket)
        new_ticket = Ticket.last
        put :update, id: new_ticket.id + 1, ticket: { purchase_date: ticket.purchase_date, movie_date: ticket.movie_date, price: ticket.price }, format: 'json'
        response.should have_http_status(:not_found)
      end
      it 'should not update the ticket with invalid input' do
        ticket = FactoryGirl.create(:ticket)
        put :update, id: ticket.id, ticket: { purchase_date: ticket.purchase_date, movie_date: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not update the ticket with invalid viewer id' do
        ticket = FactoryGirl.create(:ticket)
        new_ticket = Ticket.last
        put :update, id: new_ticket.id + 1, ticket: { purchase_date: ticket.purchase_date, movie_date: ticket.movie_date, price: ticket.price, viewer_id: nil }, format: 'json'
        response.should have_http_status(:not_found)
      end
      it 'should not update the ticket with invalid booking id' do
        ticket = FactoryGirl.create(:ticket)
        new_ticket = Ticket.last
        put :update, id: new_ticket.id + 1, ticket: { purchase_date: ticket.purchase_date, movie_date: ticket.movie_date, price: ticket.price, booking_id: nil }, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'DELETE destroy' do
      it 'should not destroy the ticket with invalid id' do
        ticket = FactoryGirl.create(:ticket)
        new_ticket = Ticket.last
        delete :destroy, id: new_ticket.id + 1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
  end
end
