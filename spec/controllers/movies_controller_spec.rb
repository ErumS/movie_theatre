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
        theatre = FactoryGirl.create(:theatre, phone_no: '5747546488')
        post :create, movie: { name: Faker::Name.name, rating: Faker::Number.between(1, 5), theatre_id: theatre.id }, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'PUT update' do
      it 'should update a valid movie' do
        movie = FactoryGirl.create(:movie)
        put :update, id: movie.id, movie: { name: 'abc', rating: movie.rating, theatre_id: movie.theatre_id }, format: 'json'
        new_movie = Movie.last
        new_movie.name.should eq 'abc'
        response.should have_http_status(:ok)
      end
    end
    context 'DELETE destroy' do
      it 'should destroy a valid movie' do
        movie = FactoryGirl.create(:movie)
        delete :destroy, id: movie.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
  end

  context 'Failure' do
    context 'GET show' do
      it 'should not show movie with invalid id' do
        movie = FactoryGirl.create(:movie)
        new_movie = Movie.last
        get :show, id: new_movie.id + 1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'POST create' do
      it 'should not create a movie with invalid input' do
        theatre = FactoryGirl.create(:theatre)
        theatre.destroy
        post :create, movie: { name: 'ABCD', rating: 555, theatre_id: theatre.id }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a movie with nil entries' do
        post :create, movie: { name: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a movie with invalid theatre id' do
        post :create, movie: { theatre_id: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
    end
    context 'PUT update' do
      it 'should not update the movie with invalid id' do
        movie = FactoryGirl.create(:movie)
        new_movie = Movie.last
        put :update, id: new_movie.id + 1, movie: { name: 'abc', rating: 3 }, format: 'json'
        response.should have_http_status(:not_found)
      end
      it 'should not update the movie with invalid input' do
        movie = FactoryGirl.create(:movie)
        put :update, id: movie.id, movie: { name: 'abc', rating: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not update the movie with invalid theatre id' do
        movie = FactoryGirl.create(:movie)
        theatre = FactoryGirl.create(:theatre)
        new_movie = Theatre.last
        put :update, id: movie.id, movie: { name: 'abc', theatre_id: new_movie.id + 1 }, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'DELETE destroy' do
      it 'should not delete the movie with invalid id' do
        movie = FactoryGirl.create(:movie)
        new_movie = Movie.last
        delete :destroy, id: new_movie.id + 1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
  end
end
