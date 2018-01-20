require 'rails_helper'

RSpec.describe SeatsController, type: :controller do
	context 'Success' do
		
		context 'GET index' do
			it 'should show all seats successfully' do
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
        theatre = FactoryGirl.create(:theatre)
        viewer = FactoryGirl.create(:viewer)
        auditorium = FactoryGirl.create(:auditorium)
				post :create, seat: {type_of_seat:"Lower", theatre_id:theatre.id, auditorium_id:auditorium.id, viewer_id:viewer.id},format: 'json'
				response.should have_http_status(:ok)
			end
		end
		context 'PUT update' do
			it 'should update a valid seat' do
				seat = FactoryGirl.create(:seat)
				put :update, id:seat.id, seat: {type_of_seat:"upper", theatre_id:seat.theatre_id, auditorium_id:seat.auditorium_id, viewer_id:seat.viewer_id}, format: 'json'
				new_seat = Seat.last
        new_seat.type_of_seat.should eq "upper"
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
        new_seat = Seat.last
				get :show, id:new_seat.id+1, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
		context 'POST create' do
			it 'should not create a seat with nil entries' do
				post :create, seat: {type_of_seat:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a seat with invalid theatre_id' do
				post :create, seat: {theatre_id:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a seat with invalid auditorium_id' do
				post :create, seat: {auditorium_id:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a seat with invalid viewer_id' do
				post :create, seat: {viewer_id:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
		end
		context 'PUT update' do
			it 'should not update the seat with invalid id' do
				seat = FactoryGirl.create(:seat)
        new_seat = Seat.last
				put :update, id:new_seat.id+1, seat: {type_of_seat:seat.type_of_seat}, format: 'json'
				response.should have_http_status(:not_found)
			end	
			it 'should not update the seat with invalid input' do
				seat = FactoryGirl.create(:seat)
				put :update, id:seat.id, seat: {type_of_seat:nil}, format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end	
			it 'should not update the seat with invalid theatre id' do
				seat = FactoryGirl.create(:seat)
        new_seat = Seat.last
        theatre = FactoryGirl.create(:theatre)
        new_theatre = Theatre.last
				put :update, id:new_seat.id+1, seat: {type_of_seat:seat.type_of_seat, theatre_id:new_theatre.id+1}, format: 'json'
				response.should have_http_status(:not_found)
			end
			it 'should not update the seat with invalid auditorium id' do
				seat = FactoryGirl.create(:seat)
        new_seat = Seat.last
        auditorium = FactoryGirl.create(:auditorium)
        new_auditorium = Auditorium.last
				put :update, id:new_seat.id+1, seat: {type_of_seat:seat.type_of_seat, auditorium_id:new_auditorium.id+1}, format: 'json'
				response.should have_http_status(:not_found)
			end
			it 'should not update the seat with invalid viewer id' do
				seat = FactoryGirl.create(:seat)
        new_seat = Seat.last
        viewer = FactoryGirl.create(:viewer)
        new_viewer = Viewer.last
				put :update, id:new_seat.id+1, seat: {type_of_seat:seat.type_of_seat, viewer_id:new_viewer.id+1}, format: 'json'
				response.should have_http_status(:not_found)
			end
		end 
		context 'DELETE destroy' do
			it 'should not destroy the seat with invalid id' do
				seat = FactoryGirl.create(:seat)
        new_seat = Seat.last
				delete :destroy, id:new_seat.id+1, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
	end
end