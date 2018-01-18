require 'rails_helper'

RSpec.describe TheatresController, type: :controller do
	context 'Success' do
		
		context 'GET index' do
			it 'should show all theatres successfully' do
				theatre1 = FactoryGirl.create(:theatre, phone_no:"545665332234")
				theatre2 = FactoryGirl.create(:theatre, phone_no:"545665332234")
	      get :index, format: 'json'
	      response.should have_http_status(:ok)
	    end
	  end
	  context 'GET show' do
	    it 'should show theatre with given id successfully' do
	      theatre = FactoryGirl.create(:theatre, phone_no:"545665332234")
	      get :show, id: theatre.id, format: 'json'
	      response.should have_http_status(:ok)
	    end
	  end
		context 'POST create' do
			it 'should create a valid theatre' do
				theatre = FactoryGirl.build(:theatre, phone_no:"44556677888")
				post :create, theatre: {name: theatre.name,address: theatre.address,phone_no: theatre.phone_no},format: 'json'
				response.should have_http_status(:ok)
			end
		end
    context 'PUT update' do
			it 'should update a valid theatre' do
				theatre = FactoryGirl.create(:theatre, phone_no:"44556677888")
				put :update, id:theatre.id, theatre: {name: "abc", address:theatre.address, phone_no:theatre.phone_no}, format: 'json'
				response.should have_http_status(:ok)
			end
		end
		context 'DELETE destroy' do
			it 'should destroy a valid theatre' do
				theatre = FactoryGirl.create(:theatre, phone_no:"44556677888")
				delete :destroy, id:theatre.id, format: 'json'
				response.should have_http_status(:ok)
			end
		end
	end

	context'Failure' do

		context 'GET show' do
			it 'should not show theatre with given id' do
				theatre = FactoryGirl.create(:theatre, phone_no:"44556677888")
        a = Theatre.last
				get :show, id:a.id+1, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
		context 'POST create' do
			it 'should not create a theatre with invalid input' do
				theatre = FactoryGirl.build(:theatre, phone_no:"44556677888")
				post :create, theatre: {name: theatre.name,address: theatre.address,phone_no:"1346"},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
			it 'should not create a theatre with nil entries' do
				theatre = FactoryGirl.build(:theatre, phone_no:"44556677888")
				post :create, theatre: {name: nil,address: theatre.address,phone_no:nil},format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end
		end
    context 'PUT update' do
			it 'should not update the theatre with invalid id' do
				theatre = FactoryGirl.create(:theatre, phone_no:"44556677888")
        a = Theatre.last
				put :update, id:a.id+1, theatre: {name: "abc", address:theatre.address, phone_no:theatre.phone_no}, format: 'json'
				response.should have_http_status(:not_found)
			end	
			it 'should not update the theatre with invalid input' do
				theatre = FactoryGirl.create(:theatre, phone_no:"44556677888")
				put :update, id:theatre.id, theatre: {name: "abc", address:theatre.address, phone_no:nil}, format: 'json'
				response.should have_http_status(:unprocessable_entity)
			end	
		end 
		context 'DELETE destroy' do
			it 'should not delete the theatre with invalid id' do
				theatre = FactoryGirl.create(:theatre, phone_no:"44556677888")
        a = Theatre.last
				delete :destroy, id:a.id+1, format: 'json'
				response.should have_http_status(:not_found)
			end
		end
	end
end