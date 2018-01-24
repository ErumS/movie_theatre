require 'rails_helper'

RSpec.describe Movie, type: :model do
  context 'Validations' do
    context 'Success' do
      it 'should be a valid movie with entries from FactoryGirl' do
        FactoryGirl.build(:movie).should be_valid
      end
      it 'should be a valid movie with manual entries' do
        FactoryGirl.build(:movie, name: 'ddsds', rating: 4).should be_valid
      end
    end

    context 'Failure' do
      it 'should not be a valid movie with invalid rating less than 1' do
        FactoryGirl.build(:movie, name: 'ddsds', rating: 0).should_not be_valid
      end
      it 'should not be a valid movie with nil name' do
        FactoryGirl.build(:movie, name: nil).should_not be_valid
      end
      it 'should not be a valid movie with nil rating' do
        FactoryGirl.build(:movie, rating: nil).should_not be_valid
      end
      it 'should not be a valid movie with nil name and rating' do
        FactoryGirl.build(:movie, name: nil, rating: nil).should_not be_valid
      end
      it 'should not be a valid movie with invalid rating' do
        FactoryGirl.build(:movie, name: 'ddsds', rating: 'rrr').should_not be_valid
      end
      it 'should not be a valid movie with invalid rating greater than 5' do
        FactoryGirl.build(:movie, name: 'eefd', rating: 55).should_not be_valid
      end
    end
  end

  context 'Associations' do
    context 'Success' do
      it 'should belongs to theatre' do
        theatre = FactoryGirl.create(:theatre)
        movie = FactoryGirl.create(:movie, theatre_id: theatre.id)
        movie.theatre.id.should eq theatre.id
      end
      it 'should have many auditoria' do
        movie = FactoryGirl.create(:movie)
        audi1 = FactoryGirl.create(:auditorium, movie_id: movie.id)
        audi2 = FactoryGirl.create(:auditorium, movie_id: movie.id)
        movie.auditoria.should include audi1
        movie.auditoria.should include audi2
      end
      it 'should have many viewers' do
        movie = FactoryGirl.create(:movie)
        viewer1 = FactoryGirl.create(:viewer, movie_id: movie.id)
        viewer2 = FactoryGirl.create(:viewer, movie_id: movie.id)
        movie.viewers.should include viewer1
        movie.viewers.should include viewer2
      end
      it 'should have many showtimes' do
        movie = FactoryGirl.create(:movie)
        showtime1 = FactoryGirl.create(:showtime, movie_id: movie.id)
        showtime2 = FactoryGirl.create(:showtime, movie_id: movie.id)
        showtime3 = FactoryGirl.create(:showtime, movie_id: movie.id)
        movie.showtimes.should include showtime1
        movie.showtimes.should include showtime2
        movie.showtimes.should include showtime3
      end
      it 'should have many bookings' do
        movie = FactoryGirl.create(:movie)
        booking1 = FactoryGirl.create(:booking, movie_id: movie.id)
        booking2 = FactoryGirl.create(:booking, movie_id: movie.id)
        movie.bookings.should include booking1
        movie.bookings.should include booking2
      end
    end

    context 'Failure' do
      it 'should not belongs to theatre' do
        theatre1 = FactoryGirl.create(:theatre)
        theatre2 = FactoryGirl.create(:theatre)
        movie1 = FactoryGirl.create(:movie, theatre_id: theatre1.id)
        movie2 = FactoryGirl.create(:movie, theatre_id: theatre2.id)
        movie1.theatre.id.should eq theatre1.id
        movie1.theatre.id.should_not eq theatre2.id
        movie2.theatre.id.should eq theatre2.id
        movie2.theatre.id.should_not eq theatre1.id
      end
      it 'should not have auditoria as a single object of movie' do
        movie = FactoryGirl.create(:movie)
        expect { movie.auditorium }.to raise_exception
        expect { movie.auditoria }.to_not raise_exception
      end
      it 'should not have viewers as a single object of movie' do
        movie = FactoryGirl.create(:movie)
        expect { movie.viewer }.to raise_exception
        expect { movie.viewers }.to_not raise_exception
      end
      it 'should not have showtimes as a single object of movie' do
        movie = FactoryGirl.create(:movie)
        expect { movie.showtime }.to raise_exception
        expect { movie.showtimes }.to_not raise_exception
      end
      it 'should not have bookings as a single object of movie' do
        movie = FactoryGirl.create(:movie)
        expect { movie.booking }.to raise_exception
        expect { movie.bookings }.to_not raise_exception
      end
    end
  end
end
