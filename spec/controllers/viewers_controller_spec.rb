require 'rails_helper'

RSpec.describe ViewersController, type: :controller do
  context 'Success' do
    context 'GET index' do
      it 'should show all viewers successfully' do
        get :index, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'GET show' do
      it 'should show viewer with given id successfully' do
        viewer = FactoryGirl.create(:viewer)
        get :show, id: viewer.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'POST create' do
      it 'should create a valid viewer' do
        theatre = FactoryGirl.create(:theatre)
        movie = FactoryGirl.create(:movie)
        post :create, viewer: { name: Faker::Name.name, phone_no: '7475646854', theatre_id: theatre.id, movie_id: movie.id }, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'PUT update' do
      it 'should update a valid viewer' do
        viewer = FactoryGirl.create(:viewer)
        put :update, id: viewer.id, viewer: { name: 'abc', phone_no: viewer.phone_no, theatre_id: viewer.theatre_id, auditorium_id: viewer.auditorium_id, movie_id: viewer.movie_id }, format: 'json'
        new_viewer = Viewer.last
        new_viewer.name.should eq 'abc'
        response.should have_http_status(:ok)
      end
    end
    context 'DELETE destroy' do
      it 'should destroy a valid viewer' do
        viewer = FactoryGirl.create(:viewer)
        delete :destroy, id: viewer.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
  end

  context 'Failure' do
    context 'GET show' do
      it 'should not show a valid viewer' do
        viewer = FactoryGirl.create(:viewer)
        new_viewer = Viewer.last
        get :show, id: new_viewer.id + 1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'POST create' do
      it 'should not create a viewer with invalid input' do
        viewer = FactoryGirl.build(:viewer)
        post :create, viewer: { name: viewer.name, phone_no: '1234', theatre_id: viewer.theatre_id, auditorium_id: viewer.auditorium_id, movie_id: viewer.movie_id }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a viewer with nil entries' do
        viewer = FactoryGirl.build(:viewer)
        post :create, viewer: { name: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a viewer with invalid theatre_id' do
        viewer = FactoryGirl.build(:viewer)
        post :create, viewer: { theatre_id: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a viewer with invalid movie_id' do
        viewer = FactoryGirl.build(:viewer)
        post :create, viewer: { movie_id: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a viewer with invalid auditorium_id' do
        viewer = FactoryGirl.build(:viewer)
        post :create, viewer: { auditorium_id: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
    end
    context 'PUT update' do
      it 'should not update the viewer with invalid id' do
        viewer = FactoryGirl.create(:viewer)
        new_viewer = Viewer.last
        put :update, id: new_viewer.id + 1, viewer: { name: 'abc', phone_no: viewer.phone_no }, format: 'json'
        response.should have_http_status(:not_found)
      end
      it 'should not update the viewer with invalid input' do
        viewer = FactoryGirl.create(:viewer)
        put :update, id: viewer.id, viewer: { name: 'abc', phone_no: nil }, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not update the viewer with invalid theatre id' do
        viewer = FactoryGirl.create(:viewer)
        new_viewer = Viewer.last
        theatre = FactoryGirl.create(:theatre)
        new_theatre = Theatre.last
        put :update, id: new_viewer.id + 1, viewer: { name: 'abc', phone_no: viewer.phone_no, theatre_id: new_theatre.id + 1 }, format: 'json'
        response.should have_http_status(:not_found)
      end
      it 'should not update the viewer with invalid movie id' do
        viewer = FactoryGirl.create(:viewer)
        new_viewer = Viewer.last
        movie = FactoryGirl.create(:movie)
        new_movie = Movie.last
        put :update, id: new_viewer.id + 1, viewer: { name: 'abc', phone_no: viewer.phone_no, movie_id: new_movie.id + 1 }, format: 'json'
        response.should have_http_status(:not_found)
      end
      it 'should not update the viewer with invalid auditorium id' do
        viewer = FactoryGirl.create(:viewer)
        new_viewer = Viewer.last
        auditorium = FactoryGirl.create(:auditorium)
        new_auditorium = Auditorium.last
        put :update, id: new_viewer.id + 1, viewer: { name: 'abc', phone_no: viewer.phone_no, auditorium_id: new_auditorium.id + 1 }, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'DELETE destroy' do
      it 'should not destroy the viewer with invalid id' do
        viewer = FactoryGirl.create(:viewer)
        new_viewer = Viewer.last
        delete :destroy, id: new_viewer.id + 1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
  end
end
