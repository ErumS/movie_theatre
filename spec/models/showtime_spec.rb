require 'rails_helper'

RSpec.describe Showtime, type: :model do
	context 'Validations' do

    context 'Success' do
  		it 'should be a valid showtime with entries from FactoryGirl' do
    		FactoryGirl.build(:showtime).should be_valid
    	end
    	it 'should be a valid showtime with manual entry' do
    		FactoryGirl.build(:showtime, time_of_show:"4:55").should be_valid
    	end
    end

    context 'Failure' do
    	it 'should not be a valid showtime with nil time_of_show' do
    		FactoryGirl.build(:showtime, time_of_show:nil).should_not be_valid
    	end
    	it 'should not be a valid showtime with invalid time_of_show' do
    		FactoryGirl.build(:showtime, time_of_show:"444").should_not be_valid
    	end
    end
	end

  context 'Associations' do

    context 'Success' do
      it 'should belongs to movie' do
        movie = FactoryGirl.create(:movie)
        showtime = FactoryGirl.create(:showtime, movie_id:movie.id)
        showtime.movie.id.should eq movie.id
      end
      it 'should have many bookings' do
        showtime = FactoryGirl.create(:showtime)
        booking1 = FactoryGirl.create(:booking, showtime_id:showtime.id)
        booking2 = FactoryGirl.create(:booking, showtime_id:showtime.id)
        showtime.bookings.should include booking1
        showtime.bookings.should include booking2    
      end
      it 'should have many tickets' do
        showtime = FactoryGirl.create(:showtime)
        ticket1 = FactoryGirl.create(:ticket, showtime_id:showtime.id)
        ticket2 = FactoryGirl.create(:ticket, showtime_id:showtime.id)
        showtime.tickets.should include ticket1
        showtime.tickets.should include ticket2
      end
    end

    context 'Failure' do
      it 'should not belongs to movie' do
        movie1 = FactoryGirl.create(:movie)
        movie2 = FactoryGirl.create(:movie)
        showtime1 = FactoryGirl.create(:showtime, movie_id:movie1.id)
        showtime2 = FactoryGirl.create(:showtime, movie_id:movie2.id)
        showtime1.movie.id.should eq movie1.id
        showtime1.movie.id.should_not eq movie2.id
        showtime2.movie.id.should eq movie2.id
        showtime2.movie.id.should_not eq movie1.id
      end
      it 'should not have bookings as a single object of showtime' do
        showtime = FactoryGirl.create(:showtime)
        expect { showtime.booking }.to raise_exception
        expect { showtime.bookings }.to_not raise_exception    
      end
      it 'should not have tickets as a single object of showtime' do
        showtime = FactoryGirl.create(:showtime)
        expect { showtime.ticket }.to raise_exception
        expect { showtime.tickets }.to_not raise_exception
      end
    end
  end
end