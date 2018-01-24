require 'rails_helper'

RSpec.describe Ticket, type: :model do
  context 'Validations' do
    context 'Success' do
      it 'should be a valid ticket with entries from FactoryGirl' do
        FactoryGirl.build(:ticket).should be_valid
      end
      it 'should be a valid ticket with manual entry of movie_date' do
        FactoryGirl.build(:ticket, movie_date: '01-02-2018').should be_valid
      end
      it 'should be a valid ticket with manual entry of purchase_date' do
        FactoryGirl.build(:ticket, purchase_date: '01-02-2018').should be_valid
      end
      it 'should be a valid ticket with manual entry of price' do
        FactoryGirl.build(:ticket, price: 125.50).should be_valid
      end
      it 'should be a valid ticket with manual entry of movie_date and purchase_date' do
        FactoryGirl.build(:ticket, movie_date: '01-02-2018', purchase_date: '01-02-2018').should be_valid
      end
      it 'should be a valid ticket with manual entry of movie_date and price' do
        FactoryGirl.build(:ticket, movie_date: '01-02-2018', price: 125.50).should be_valid
      end
      it 'should be a valid ticket with manual entry of purchase_date and price' do
        FactoryGirl.build(:ticket, purchase_date: '01-02-2018', price: 125.50).should be_valid
      end
      it 'should be a valid ticket with manual entry of movie_date, purchase_date and price' do
        FactoryGirl.build(:ticket, movie_date: '01-02-2018', purchase_date: '01-02-2018', price: 125.50).should be_valid
      end
    end

    context 'Failure' do
      it 'should not be a valid ticket with nil movie_date' do
        FactoryGirl.build(:ticket, movie_date: nil).should_not be_valid
      end
      it 'should not be a valid ticket with nil purchase_date' do
        FactoryGirl.build(:ticket, purchase_date: nil).should_not be_valid
      end
      it 'should not be a valid ticket with nil price' do
        FactoryGirl.build(:ticket, price: nil).should_not be_valid
      end
      it 'should not be a valid ticket with nil movie_date and purchase_date' do
        FactoryGirl.build(:ticket, movie_date: nil, purchase_date: nil).should_not be_valid
      end
      it 'should not be a valid ticket with nil movie_date and price' do
        FactoryGirl.build(:ticket, movie_date: nil, price: nil).should_not be_valid
      end
      it 'should not be a valid ticket with nil purchase_date and price' do
        FactoryGirl.build(:ticket, purchase_date: nil, price: nil).should_not be_valid
      end
      it 'should not be a valid ticket with nil movie_date, purchase_date and price' do
        FactoryGirl.build(:ticket, movie_date: nil, purchase_date: nil, price: nil).should_not be_valid
      end
    end
  end

  context 'Associations' do
    context 'Success' do
      it 'should belongs to viewer' do
        viewer = FactoryGirl.create(:viewer)
        ticket = FactoryGirl.create(:ticket, viewer_id: viewer.id)
        ticket.viewer.id.should eq viewer.id
      end
      it 'should belongs to showtime' do
        showtime = FactoryGirl.create(:showtime)
        ticket = FactoryGirl.create(:ticket, showtime_id: showtime.id)
        ticket.showtime.id.should eq showtime.id
      end
    end

    context 'Failure' do
      it 'should not belongs to viewer' do
        viewer1 = FactoryGirl.create(:viewer)
        viewer2 = FactoryGirl.create(:viewer)
        ticket1 = FactoryGirl.create(:ticket, viewer_id: viewer1.id)
        ticket2 = FactoryGirl.create(:ticket, viewer_id: viewer2.id)
        ticket1.viewer.id.should eq viewer1.id
        ticket1.viewer.id.should_not eq viewer2.id
        ticket2.viewer.id.should eq viewer2.id
        ticket2.viewer.id.should_not eq viewer1.id
      end
      it 'should not belongs to showtime' do
        showtime1 = FactoryGirl.create(:showtime)
        showtime2 = FactoryGirl.create(:showtime)
        ticket1 = FactoryGirl.create(:ticket, showtime_id: showtime1.id)
        ticket2 = FactoryGirl.create(:ticket, showtime_id: showtime2.id)
        ticket1.showtime.id.should eq showtime1.id
        ticket1.showtime.id.should_not eq showtime2.id
        ticket2.showtime.id.should eq showtime2.id
        ticket2.showtime.id.should_not eq showtime1.id
      end
    end
  end
end
