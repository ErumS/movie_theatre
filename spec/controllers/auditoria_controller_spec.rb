require 'rails_helper'

RSpec.describe AuditoriaController, type: :controller do
	context 'Success' do
		
		context 'GET index' do
			it 'should show all auditoria successfully' do
	      get :index, format: 'json'
	      response.should have_http_status(:ok)
	    end
	  end
	  context 'GET show' do
	    it 'should show auditorium with given id successfully' do
	      auditorium = FactoryGirl.create(:auditorium)
	      get :show, id: auditorium.id, format: 'json'
	      response.should have_http_status(:ok)
	    end
	  end
		context 'POST create' do
			it 'should create a valid auditorium' do
        theatre = FactoryGirl.create(:theatre)
        movie = FactoryGirl.create(:movie)
				post :create, auditorium: {screen_size:"5x5", no_of_seats:100, theatre_id:theatre.id, movie_id:movie.id},format: 'json'
				response.should have_http_status(:ok)
			end
		end
		context 'PUT update' do
			it 'should update a valid auditorium' do
				auditorium = FactoryGirl.create(:auditorium)
				put :update, id:auditorium.id, auditorium: {screen_size:"4x4", no_of_seats:60, theatre_id:auditorium.theatre_id}, format: 'json'
				new_auditorium = Auditorium.last
        new_auditorium.screen_size.should eq "4x4"
        response.should have_http_status(:ok)
			end
		end
		context 'DELETE destroy' do
			it 'should destroy a valid auditorium' do
				auditorium = FactoryGirl.create(:auditorium)
				delete :destroy, id:auditorium.id, format: 'json'
				response.should have_http_status(:ok)
			end
		end
	end

	context'Failure' do

		context 'GET show' do
			it 'should not show a valid auditorium' do
				auditorium = FactoryGirl.create(:auditorium)
        new_auditorium = Auditorium.last
				get :show, id:new_auditorium.id+1, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
		context 'POST create' do
			it 'should not create an auditorium with invalid input' do
				post :create, auditorium: {screen_size:"6x6", no_of_seats:5000}, format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create an auditorium with nil entries' do
				post :create, auditorium: {screen_size:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create an auditorium with invalid theatre id' do
				post :create, auditorium: {theatre_id:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create an auditorium with invalid movie id' do
				post :create, auditorium: {movie_id:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
		end
		context 'PUT update' do
			it 'should not update the auditorium with invalid id' do
				auditorium = FactoryGirl.create(:auditorium)
        new_auditorium = Auditorium.last
				put :update, id:new_auditorium.id+1, auditorium: {screen_size:auditorium.screen_size, no_of_seats:auditorium.no_of_seats}, format: 'json'
				response.should have_http_status(:not_found)
			end	
			it 'should not update the auditorium with invalid input' do
				auditorium = FactoryGirl.create(:auditorium)
				put :update, id:auditorium.id, auditorium: {screen_size:auditorium.screen_size, no_of_seats:nil}, format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end	
			it 'should not update the auditorium with invalid theatre id' do
				auditorium = FactoryGirl.create(:auditorium)
        new_auditorium = Auditorium.last
        theatre = FactoryGirl.create(:theatre)
        new_theatre = Theatre.last
				put :update, id:new_auditorium.id+1, auditorium: {screen_size:auditorium.screen_size, no_of_seats:auditorium.no_of_seats, theatre_id:new_theatre.id+1}, format: 'json'
				response.should have_http_status(:not_found)
			end
			it 'should not update the auditorium with invalid movie id' do
				auditorium = FactoryGirl.create(:auditorium)
        new_auditorium = Auditorium.last
        movie = FactoryGirl.create(:movie)
        new_movie = Movie.last
				put :update, id:new_auditorium.id+1, auditorium: {screen_size:auditorium.screen_size, no_of_seats:auditorium.no_of_seats, movie_id:new_movie.id+1}, format: 'json'
				response.should have_http_status(:not_found)
			end
		end 
		context 'DELETE destroy' do
			it 'should not destroy the auditorium with invalid id' do
				auditorium = FactoryGirl.create(:auditorium)
        new_auditorium = Auditorium.last
				delete :destroy, id:new_auditorium.id+1, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
	end
end