require 'rails_helper'

RSpec.describe SeatsController, type: :controller do
	context 'Success' do
		
		context 'GET index' do
			it 'should show all seats successfully' do
				seat1 = FactoryGirl.create(:seat)
				seat2 = FactoryGirl.create(:seat)
	      get :index, format: 'json'
	      response.should have_http_status(:ok)
	    end
	  end
	  context 'GET show' do
	    it 'should show seat with given id successfully' do
	      seat = FactoryGirl.create(:seat)
	      get :show, id: seat.id, format: 'json'
	      response.should have_http_status(:ok)
	    end
	  end
		context 'POST create' do
			it 'should create a valid seat' do
				seat = FactoryGirl.build(:seat)
				post :create, seat: {type_of_seat:seat.type_of_seat, theatre_id:seat.theatre_id, auditorium_id:seat.auditorium_id, viewer_id:seat.viewer_id},format: 'json'
				response.should have_http_status(:ok)
			end
		end
		context 'PUT update' do
			it 'should update a valid seat' do
				seat = FactoryGirl.create(:seat)
				put :update, id:seat.id, seat: {type_of_seat:"upper", theatre_id:seat.theatre_id, auditorium_id:seat.auditorium_id, viewer_id:seat.viewer_id}, format: 'json'
				response.should have_http_status(:ok)
			end
		end
		context 'DELETE destroy' do
			it 'should destroy a valid seat' do
				seat = FactoryGirl.create(:seat)
				delete :destroy, id:seat.id, format: 'json'
				response.should have_http_status(:ok)
			end
		end
	end

	context'Failure' do

		context 'GET show' do
			it 'should not show a valid seat' do
				seat = FactoryGirl.create(:seat)
        a = Seat.last
				get :show, id:a.id+1, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
		context 'POST create' do
			it 'should not create a seat with nil entries' do
				seat = FactoryGirl.build(:seat)
				post :create, seat: {type_of_seat:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a seat with invalid theatre_id' do
				seat = FactoryGirl.build(:seat)
				post :create, seat: {theatre_id:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a seat with invalid auditorium_id' do
				seat = FactoryGirl.build(:seat)
				post :create, seat: {auditorium_id:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a seat with invalid viewer_id' do
				seat = FactoryGirl.build(:seat)
				post :create, seat: {viewer_id:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
		end
		context 'PUT update' do
			it 'should not update the seat with invalid id' do
				seat = FactoryGirl.create(:seat)
        a = Seat.last
				put :update, id:a.id+1, seat: {type_of_seat:seat.type_of_seat}, format: 'json'
				response.should have_http_status(:not_found)
			end	
			it 'should not update the seat with invalid input' do
				seat = FactoryGirl.create(:seat)
				put :update, id:seat.id, seat: {type_of_seat:nil}, format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end	
			it 'should not update the seat with invalid theatre id' do
				seat = FactoryGirl.create(:seat)
        a = Seat.last
        theatre = FactoryGirl.create(:theatre, phone_no:"56457774322")
        b = Theatre.last
				put :update, id:a.id+1, seat: {type_of_seat:seat.type_of_seat, theatre_id:b.id+1}, format: 'json'
				response.should have_http_status(:not_found)
			end
			it 'should not update the seat with invalid auditorium id' do
				seat = FactoryGirl.create(:seat)
        a = Seat.last
        auditorium = FactoryGirl.create(:auditorium)
        b = Auditorium.last
				put :update, id:a.id+1, seat: {type_of_seat:seat.type_of_seat, auditorium_id:b.id+1}, format: 'json'
				response.should have_http_status(:not_found)
			end
			it 'should not update the seat with invalid viewer id' do
				seat = FactoryGirl.create(:seat)
        a = Seat.last
        viewer = FactoryGirl.create(:viewer, phone_no:"56457774322")
        b = Viewer.last
				put :update, id:a.id+1, seat: {type_of_seat:seat.type_of_seat, viewer_id:b.id+1}, format: 'json'
				response.should have_http_status(:not_found)
			end
		end 
		context 'DELETE destroy' do
			it 'should not destroy the seat with invalid id' do
				seat = FactoryGirl.create(:seat)
        a = Seat.last
				delete :destroy, id:a.id+1, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
	end
end