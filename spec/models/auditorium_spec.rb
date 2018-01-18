require 'rails_helper'

RSpec.describe Auditorium, type: :model do
	context 'Validations' do

    context 'Success' do
  		it 'should be a valid auditorium with entries from FactoryGirl' do
    		FactoryGirl.build(:auditorium).should be_valid
    	end
    	it 'should be a valid auditorium with manual entries of screen_size and no_of_seats' do
    		FactoryGirl.build(:auditorium, screen_size:"abc", no_of_seats:54).should be_valid
    	end
    	it 'should be a valid auditorium with manual entries of no_of_seats' do
    		FactoryGirl.build(:auditorium, no_of_seats:54).should be_valid
    	end
    	it 'should be a valid auditorium with manual entries of screen_size' do
    		FactoryGirl.build(:auditorium, screen_size:"abc").should be_valid
    	end
    end

    context 'Failure' do
    	it 'should not be a valid auditorium with nil screen_size' do
    		FactoryGirl.build(:auditorium, screen_size:nil).should_not be_valid
    	end
    	it 'should not be a valid auditorium with nil no_of_seats' do
    		FactoryGirl.build(:auditorium, no_of_seats:nil).should_not be_valid
    	end
    	it 'should not be a valid auditorium with nil screen_size and no_of_seats' do
    		FactoryGirl.build(:auditorium, screen_size:nil, no_of_seats:nil).should_not be_valid
    	end
    end
	end

  context 'Associations' do

    context 'Success' do
      it 'should belongs to theatre' do
        theatre = FactoryGirl.create(:theatre, phone_no:"3344556677")
        auditorium = FactoryGirl.create(:auditorium ,theatre_id:theatre.id)
        auditorium.theatre.id.should eq theatre.id
      end
      it 'should belongs to movie' do
        movie = FactoryGirl.create(:movie)
        auditorium = FactoryGirl.create(:auditorium ,movie_id:movie.id)
        auditorium.movie.id.should eq movie.id
      end
      it 'should have many viewers' do
        auditorium = FactoryGirl.create(:auditorium)
        viewer1 = FactoryGirl.create(:viewer, auditorium_id:auditorium.id)
        viewer2 = FactoryGirl.create(:viewer, auditorium_id:auditorium.id)
        auditorium.viewers.should include viewer1
        auditorium.viewers.should include viewer2 
      end
      it 'should have many bookings' do
        auditorium = FactoryGirl.create(:auditorium)
        booking1 = FactoryGirl.create(:booking, auditorium_id:auditorium.id)
        booking2 = FactoryGirl.create(:booking, auditorium_id:auditorium.id)
        auditorium.bookings.should include booking1
        auditorium.bookings.should include booking2    
      end
      it 'should have many seats' do
        auditorium = FactoryGirl.create(:auditorium)
        seat1 = FactoryGirl.create(:seat, auditorium_id:auditorium.id)
        seat2 = FactoryGirl.create(:seat, auditorium_id:auditorium.id)
        seat3 = FactoryGirl.create(:seat, auditorium_id:auditorium.id)
        auditorium.seats.should include seat1
        auditorium.seats.should include seat2
        auditorium.seats.should include seat3
      end
    end

    context 'Failure' do
      it 'should not belongs to theatre' do
        theatre1 = FactoryGirl.create(:theatre, phone_no:"3344556677")
        theatre2 = FactoryGirl.create(:theatre, phone_no:"3344556677")
        auditorium1 = FactoryGirl.create(:auditorium, theatre_id:theatre1.id)
        auditorium2 = FactoryGirl.create(:auditorium, theatre_id:theatre2.id)
        auditorium1.theatre.id.should eq theatre1.id
        auditorium1.theatre.id.should_not eq theatre2.id
        auditorium2.theatre.id.should eq theatre2.id
        auditorium2.theatre.id.should_not eq theatre1.id
      end
      it 'should not belongs to movie' do
        movie1 = FactoryGirl.create(:movie)
        movie2 = FactoryGirl.create(:movie)
        auditorium1 = FactoryGirl.create(:auditorium, movie_id:movie1.id)
        auditorium2 = FactoryGirl.create(:auditorium, movie_id:movie2.id)
        auditorium1.movie.id.should eq movie1.id
        auditorium1.movie.id.should_not eq movie2.id
        auditorium2.movie.id.should eq movie2.id
        auditorium2.movie.id.should_not eq movie1.id
      end  
      it 'should not have viewers as a single object of auditorium' do
        auditorium = FactoryGirl.create(:auditorium)
        expect { auditorium.viewer }.to raise_exception
        expect { auditorium.viewers }.to_not raise_exception
      end
      it 'should not have bookings as a single object of auditorium' do
        auditorium = FactoryGirl.create(:auditorium)
        expect { auditorium.booking }.to raise_exception
        expect { auditorium.bookings }.to_not raise_exception    
      end
      it 'should not have seats as a single object of auditorium' do
        auditorium = FactoryGirl.create(:auditorium)
        expect { auditorium.seat }.to raise_exception
        expect { auditorium.seats }.to_not raise_exception
      end
    end
  end
end