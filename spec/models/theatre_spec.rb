require 'rails_helper'

RSpec.describe Theatre, type: :model do
  context 'Validations' do

    context 'Success' do
    	it 'should be a valid theatre with manual entries' do
    		FactoryGirl.build(:theatre, name:"Inox", address:"University", phone_no:"444444443").should be_valid
    	end
      it 'should be a valid theatre with all entries from FactoryGirl' do
        FactoryGirl.build(:theatre).should be_valid
      end
    end

    context 'Failure' do
    	it 'should not be a valid theatre with invalid phone number' do
    		FactoryGirl.build(:theatre, name: "Inox", address: "University", phone_no: "44434").should_not be_valid
    	end
    	it 'should not be a valid theatre with invalid phone number' do
    		FactoryGirl.build(:theatre, phone_no: "44434678783487387874755").should_not be_valid
    	end
    	it 'should not be a valid theatre with nil address' do
    		FactoryGirl.build(:theatre, address: nil).should_not be_valid
    	end  
      it 'should not be a valid theatre with nil name' do
        FactoryGirl.build(:theatre, name:nil).should_not be_valid
      end 
      it 'should not be a valid theatre with nil phone number' do
        FactoryGirl.build(:theatre, phone_no: nil).should_not be_valid
      end 
      it 'should not be a valid theatre with nil address and phone number' do
        FactoryGirl.build(:theatre, address:nil, phone_no:nil).should_not be_valid
      end
      it 'should not be a valid theatre with nil name and address' do
        FactoryGirl.build(:theatre, name:nil, address:nil).should_not be_valid
      end
      it 'should not be a valid theatre with nil name and phone number' do
        FactoryGirl.build(:theatre, name:nil, phone_no:nil).should_not be_valid
      end 
      it 'should not be a valid theatre with nil name, address and phone number' do
        FactoryGirl.build(:theatre, name:nil, address:nil, phone_no:nil).should_not be_valid
      end
      it 'should not be a valid theatre with invalid phone number type' do
        FactoryGirl.build(:theatre, phone_no:454545).should_not be_valid
      end
    end
  end

  context 'Associations' do

    context 'Success' do
      it 'should have many movies' do
        theatre = FactoryGirl.create(:theatre)
        movie1 = FactoryGirl.create(:movie, theatre_id:theatre.id)
        movie2 = FactoryGirl.create(:movie, theatre_id:theatre.id)
        theatre.movies.should include movie1
        theatre.movies.should include movie2 
      end
      it 'should have many auditoria' do
        theatre = FactoryGirl.create(:theatre)
        audi1 = FactoryGirl.create(:auditorium, theatre_id:theatre.id)
        audi2 = FactoryGirl.create(:auditorium, theatre_id:theatre.id)
        theatre.auditoria.should include audi1
        theatre.auditoria.should include audi2
      end
      it 'should have many viewers' do
        theatre = FactoryGirl.create(:theatre)
        viewer1 = FactoryGirl.create(:viewer, theatre_id:theatre.id)
        viewer2 = FactoryGirl.create(:viewer, theatre_id:theatre.id)
        theatre.viewers.should include viewer1
        theatre.viewers.should include viewer2    
      end
      it 'should have many bookings' do
        theatre = FactoryGirl.create(:theatre)
        booking1 = FactoryGirl.create(:booking, theatre_id:theatre.id)
        booking2 = FactoryGirl.create(:booking, theatre_id:theatre.id)
        theatre.bookings.should include booking1
        theatre.bookings.should include booking2    
      end
      it 'should have many seats' do
        theatre = FactoryGirl.create(:theatre)
        seat1 = FactoryGirl.create(:seat, theatre_id:theatre.id)
        seat2 = FactoryGirl.create(:seat, theatre_id:theatre.id)
        seat3 = FactoryGirl.create(:seat, theatre_id:theatre.id)
        theatre.seats.should include seat1
        theatre.seats.should include seat2
        theatre.seats.should include seat3
      end
    end

    context 'Failure' do
      it 'should not have movies as a single object of theatre' do
        theatre = FactoryGirl.create(:theatre)
        expect { theatre.movie }.to raise_exception
        expect { theatre.movies }.to_not raise_exception 
      end
      it 'should not have auditoria as a single object of theatre' do
        theatre = FactoryGirl.create(:theatre)
        expect { theatre.auditorium }.to raise_exception
        expect { theatre.auditoria }.to_not raise_exception
      end
      it 'should not have viewers as a single object of theatre' do
        theatre = FactoryGirl.create(:theatre)
        expect { theatre.viewer }.to raise_exception
        expect { theatre.viewers }.to_not raise_exception 
      end
      it 'should not have bookings as a single object of theatre' do
        theatre = FactoryGirl.create(:theatre)
        expect { theatre.booking }.to raise_exception
        expect { theatre.bookings }.to_not raise_exception   
      end
      it 'should not have seats as a single object of theatre' do
        theatre = FactoryGirl.create(:theatre)
        expect { theatre.seat }.to raise_exception
        expect { theatre.seats }.to_not raise_exception
      end
    end
  end
end