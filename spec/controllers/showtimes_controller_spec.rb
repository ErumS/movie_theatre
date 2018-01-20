require 'rails_helper'

RSpec.describe ShowtimesController, type: :controller do
	context 'Success' do
		
		context 'GET index' do
			it 'should show all showtimes successfully' do
	      get :index, format: 'json'
	      response.should have_http_status(:ok)
	    end
	  end
	  context 'GET show' do
	    it 'should show showtime with given id successfully' do
	      showtime = FactoryGirl.create(:showtime)
	      get :show, id: showtime.id, format: 'json'
	      response.should have_http_status(:ok)
	    end
	  end
		context 'POST create' do
			it 'should create a valid showtime' do
        movie = FactoryGirl.create(:movie)
				post :create, showtime: {time_of_show:"5:22", movie_id:movie.id},format: 'json'
				response.should have_http_status(:ok)
			end
		end
		context 'PUT update' do
			it 'should update a valid showtime' do
				showtime = FactoryGirl.create(:showtime)
				put :update, id:showtime.id, showtime: {time_of_show:"4:55", movie_id:showtime.movie_id}, format: 'json'
				new_showtime = Showtime.last
        new_showtime.time_of_show.should eq "2000-01-01 04:55:00.000000000 +0000"
        response.should have_http_status(:ok)
			end
		end
		context 'DELETE destroy' do
			it 'should destroy a valid showtime' do
				showtime = FactoryGirl.create(:showtime)
				delete :destroy, id:showtime.id, format: 'json'
				response.should have_http_status(:ok)
			end
		end
	end

	context'Failure' do

		context 'GET show' do
			it 'should not show a valid showtime' do
				showtime = FactoryGirl.create(:showtime)
        new_showtime = Showtime.last
				get :show, id:new_showtime.id+1, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
		context 'POST create' do
			it 'should not create a showtime with invalid input' do
				post :create, showtime: {time_of_show: "45645"},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a showtime with nil entries' do
				post :create, showtime: {time_of_show:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a showtime with invalid movie id' do
				post :create, showtime: {time_of_show: "45645", movie_id:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
		end
		context 'PUT update' do
			it 'should not update the showtime with invalid id' do
				showtime = FactoryGirl.create(:showtime)
        new_showtime = Showtime.last
				put :update, id:new_showtime.id+1, showtime: {time_of_show:showtime.time_of_show}, format: 'json'
				response.should have_http_status(:not_found)
			end	
			it 'should not update the showtime with invalid input' do
				showtime = FactoryGirl.create(:showtime)
				put :update, id:showtime.id, showtime: {time_of_show:nil}, format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end	
			it 'should not update the showtime with invalid movie id' do
				showtime = FactoryGirl.create(:showtime)
        new_showtime = Showtime.last
				put :update, id:new_showtime.id+1, showtime: {movie_id:nil}, format: 'json'
				response.should have_http_status(:not_found)
			end
		end 
		context 'DELETE destroy' do
			it 'should not destroy the showtime with invalid id' do
				showtime = FactoryGirl.create(:showtime)
        new_showtime = Showtime.last
				delete :destroy, id:new_showtime.id+1, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
	end
end