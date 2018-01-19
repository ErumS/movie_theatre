require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
	context 'Success' do
		
		context 'GET index' do
			it 'should show all movies successfully' do
	      get :index, format: 'json'
	      response.should have_http_status(:ok)
	    end
	  end
	  context 'GET show' do
	    it 'should show movie with given id successfully' do
	      movie = FactoryGirl.create(:movie)
	      get :show, id: movie.id, format: 'json'
	      response.should have_http_status(:ok)
	    end
	  end
		context 'POST create' do
			it 'should create a valid movie' do
				movie = FactoryGirl.build(:movie)
				post :create, movie: {name: movie.name, rating:movie.rating, theatre_id:movie.theatre_id},format: 'json'
				response.should have_http_status(:ok)
			end
		end
		context 'PUT update' do
			it 'should update a valid movie' do
				movie = FactoryGirl.create(:movie)
				put :update, id:movie.id, movie: {name: "abc", rating:movie.rating, theatre_id:movie.theatre_id}, format: 'json'
				response.should have_http_status(:ok)
			end
		end
		context 'DELETE destroy' do
			it 'should destroy a valid movie' do
				movie = FactoryGirl.create(:movie)
				delete :destroy, id:movie.id, format: 'json'
				response.should have_http_status(:ok)
			end
		end
	end

	context'Failure' do

		context 'GET show' do
			it 'should not show movie with invalid id' do
				movie = FactoryGirl.create(:movie)
        a = Movie.last
				get :show, id:a.id+1, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
		context 'POST create' do
			it 'should not create a movie with invalid input' do
				movie = FactoryGirl.build(:movie)
				post :create, movie: {name: movie.name, rating:555},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a movie with nil entries' do
				movie = FactoryGirl.build(:movie)
				post :create, movie: {name: nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a movie with invalid theatre id' do
				movie = FactoryGirl.build(:movie)
				post :create, movie: {theatre_id:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
		end
		context 'PUT update' do
			it 'should not update the movie with invalid id' do
				movie = FactoryGirl.create(:movie)
        a = Movie.last
				put :update, id:a.id+1, movie: {name: "abc", rating:3}, format: 'json'
				response.should have_http_status(:not_found)
			end	
			it 'should not update the movie with invalid input' do
				movie = FactoryGirl.create(:movie)
				put :update, id:movie.id, movie: {name: "abc", rating:nil}, format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end	
			it 'should not update the movie with invalid theatre id' do
				movie = FactoryGirl.create(:movie)
        theatre = FactoryGirl.create(:theatre, phone_no:"6667777799")
        a = Theatre.last
				put :update, id:movie.id, movie: {name: "abc", theatre_id:a.id+1}, format: 'json'
				response.should have_http_status(:not_found)
			end	
		end 
		context 'DELETE destroy' do
			it 'should not delete the movie with invalid id' do
				movie = FactoryGirl.create(:movie)
        a = Movie.last
				delete :destroy, id:a.id+1, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
	end
end