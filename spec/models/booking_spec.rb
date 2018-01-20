require 'rails_helper'

RSpec.describe Booking, type: :model do
	context 'Validations' do

    context 'Success' do
  		it 'should be a valid booking' do
    		FactoryGirl.build(:booking).should be_valid
    	end
    	it 'should be a valid booking' do
    		FactoryGirl.build(:booking, booking_category:"recliner", no_of_bookings:4).should be_valid
    	end
    end

    context 'Failure' do
    	it 'should not be a valid booking' do
    		FactoryGirl.build(:booking, booking_category:"recliner", no_of_bookings:nil).should_not be_valid
    	end
    	it 'should not be a valid booking' do
    		FactoryGirl.build(:booking, booking_category:"middle", no_of_bookings:49).should_not be_valid
    	end
    	it 'should not be a valid booking' do
    		FactoryGirl.build(:booking, booking_category:nil).should_not be_valid
    	end
    	it 'should not be a valid booking' do
    		FactoryGirl.build(:booking, no_of_bookings:nil).should_not be_valid
    	end
    	it 'should not be a valid booking' do
    		FactoryGirl.build(:booking, booking_category:nil, no_of_bookings:nil).should_not be_valid
    	end
    	it 'should not be a valid booking' do
    		FactoryGirl.build(:booking, booking_category:"recliner", no_of_bookings:"abcd").should_not be_valid
    	end
    	it 'should not be a valid booking' do
    		FactoryGirl.build(:booking, booking_category:"lower", no_of_bookings:0).should_not be_valid
    	end
    end
	end


	context 'Associations' do

	context 'Success' do
		it 'should belongs to theatre' do
        theatre = FactoryGirl.create(:theatre)
        booking = FactoryGirl.create(:booking, theatre_id:theatre.id)
        booking.theatre.id.should eq theatre.id
      end
      it 'should belongs to movie' do
        movie = FactoryGirl.create(:movie)
        booking = FactoryGirl.create(:booking, movie_id:movie.id)
        booking.movie.id.should eq movie.id
      end
      it 'should belongs to auditorium' do
        auditorium = FactoryGirl.create(:auditorium)
        booking = FactoryGirl.create(:booking, auditorium_id:auditorium.id)
        booking.auditorium.id.should eq auditorium.id
      end
      it 'should belongs to viewer' do
        viewer = FactoryGirl.create(:viewer)
        booking = FactoryGirl.create(:booking, viewer_id:viewer.id)
        booking.viewer.id.should eq viewer.id
      end
      it 'should belongs to showtime' do
        showtime = FactoryGirl.create(:showtime)
        booking = FactoryGirl.create(:booking, showtime_id:showtime.id)
        booking.showtime.id.should eq showtime.id
      end
      it 'should have many tickets' do
        booking = FactoryGirl.create(:booking)
        ticket1 = FactoryGirl.create(:ticket, booking_id:booking.id)
        ticket2 = FactoryGirl.create(:ticket, booking_id:booking.id) 
        ticket3 = FactoryGirl.create(:ticket, booking_id:booking.id)
        booking.tickets.should include ticket1
        booking.tickets.should include ticket2
        booking.tickets.should include ticket3
      end
		end

		context 'Failure' do
      it 'should not belongs to theatre' do
        theatre1 = FactoryGirl.create(:theatre)
        theatre2 = FactoryGirl.create(:theatre)
        booking1 = FactoryGirl.create(:booking, theatre_id:theatre1.id)
        booking2 = FactoryGirl.create(:booking, theatre_id:theatre2.id)
        booking1.theatre.id.should eq theatre1.id
        booking1.theatre.id.should_not eq theatre2.id
        booking2.theatre.id.should eq theatre2.id
        booking2.theatre.id.should_not eq theatre1.id
      end
      it 'should not belongs to movie' do
        movie1 = FactoryGirl.create(:movie)
        movie2 = FactoryGirl.create(:movie)
        booking1 = FactoryGirl.create(:booking, movie_id:movie1.id)
        booking2 = FactoryGirl.create(:booking, movie_id:movie2.id)
        booking1.movie.id.should eq movie1.id
        booking1.movie.id.should_not eq movie2.id
        booking2.movie.id.should eq movie2.id
        booking2.movie.id.should_not eq movie1.id
      end
      it 'should not belongs to auditorium' do
        auditorium1 = FactoryGirl.create(:auditorium)
        auditorium2 = FactoryGirl.create(:auditorium)
        booking1 = FactoryGirl.create(:booking, auditorium_id:auditorium1.id)
        booking2 = FactoryGirl.create(:booking, auditorium_id:auditorium2.id)
        booking1.auditorium.id.should eq auditorium1.id
        booking1.auditorium.id.should_not eq auditorium2.id
        booking2.auditorium.id.should eq auditorium2.id
        booking2.auditorium.id.should_not eq auditorium1.id
      end
      it 'should not belongs to viewer' do
        viewer1 = FactoryGirl.create(:viewer)
        viewer2 = FactoryGirl.create(:viewer)
        booking1 = FactoryGirl.create(:booking, viewer_id:viewer1.id)
        booking2 = FactoryGirl.create(:booking, viewer_id:viewer2.id)
        booking1.viewer.id.should eq viewer1.id
        booking1.viewer.id.should_not eq viewer2.id
        booking2.viewer.id.should eq viewer2.id
        booking2.viewer.id.should_not eq viewer1.id
      end
      it 'should not belongs to showtime' do
        showtime1 = FactoryGirl.create(:showtime)
        showtime2 = FactoryGirl.create(:showtime)
        booking1 = FactoryGirl.create(:booking, showtime_id:showtime1.id)
        booking2 = FactoryGirl.create(:booking, showtime_id:showtime2.id)
        booking1.showtime.id.should eq showtime1.id
        booking1.showtime.id.should_not eq showtime2.id
        booking2.showtime.id.should eq showtime2.id
        booking2.showtime.id.should_not eq showtime1.id
      end
			it 'should not have many tickets' do
        booking = FactoryGirl.create(:booking)
        expect { booking.ticket }.to raise_exception
        expect { booking.tickets }.to_not raise_exception
      end
	end
	end
end