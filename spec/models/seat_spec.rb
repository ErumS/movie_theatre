require 'rails_helper'

RSpec.describe Seat, type: :model do
  context 'Validations' do
    context 'Success' do
      it 'should be a valid seat with entries from FactoryGirl' do
        FactoryGirl.build(:seat).should be_valid
      end
      it 'should be a valid seat with manual entry of type_of_seat' do
        FactoryGirl.build(:seat, type_of_seat: 'lower').should be_valid
      end
      it 'should be a valid seat with manual entry of type_of_seat' do
        FactoryGirl.build(:seat, type_of_seat: 'middle').should be_valid
      end
      it 'should be a valid seat with manual entry of type_of_seat' do
        FactoryGirl.build(:seat, type_of_seat: 'recliner').should be_valid
      end
    end

    context 'Failure' do
      it 'should not be a valid seat with nil entry of type_of_seat' do
        FactoryGirl.build(:seat, type_of_seat: nil).should_not be_valid
      end
    end
  end

  context 'Associations' do
    context 'Success' do
      it 'should belongs to theatre' do
        theatre = FactoryGirl.create(:theatre)
        seat = FactoryGirl.create(:seat, theatre_id: theatre.id)
        seat.theatre.id.should eq theatre.id
      end
      it 'should belongs to viewer' do
        viewer = FactoryGirl.create(:viewer)
        seat = FactoryGirl.create(:seat, viewer_id: viewer.id)
        seat.viewer.id.should eq viewer.id
      end
      it 'should belongs to auditorium' do
        auditorium = FactoryGirl.create(:auditorium)
        seat = FactoryGirl.create(:seat, auditorium_id: auditorium.id)
        seat.auditorium.id.should eq auditorium.id
      end
    end

    context 'Failure' do
      it 'should not belongs to theatre' do
        theatre1 = FactoryGirl.create(:theatre)
        theatre2 = FactoryGirl.create(:theatre)
        seat1 = FactoryGirl.create(:seat, theatre_id: theatre1.id)
        seat2 = FactoryGirl.create(:seat, theatre_id: theatre2.id)
        seat1.theatre.id.should eq theatre1.id
        seat1.theatre.id.should_not eq theatre2.id
        seat2.theatre.id.should eq theatre2.id
        seat2.theatre.id.should_not eq theatre1.id
      end
      it 'should not belongs to auditorium' do
        auditorium1 = FactoryGirl.create(:auditorium)
        auditorium2 = FactoryGirl.create(:auditorium)
        seat1 = FactoryGirl.create(:seat, auditorium_id: auditorium1.id)
        seat2 = FactoryGirl.create(:seat, auditorium_id: auditorium2.id)
        seat1.auditorium.id.should eq auditorium1.id
        seat1.auditorium.id.should_not eq auditorium2.id
        seat2.auditorium.id.should eq auditorium2.id
        seat2.auditorium.id.should_not eq auditorium1.id
      end
      it 'should not belongs to viewer' do
        viewer1 = FactoryGirl.create(:viewer)
        viewer2 = FactoryGirl.create(:viewer)
        seat1 = FactoryGirl.create(:seat, viewer_id: viewer1.id)
        seat2 = FactoryGirl.create(:seat, viewer_id: viewer2.id)
        seat1.viewer.id.should eq viewer1.id
        seat1.viewer.id.should_not eq viewer2.id
        seat2.viewer.id.should eq viewer2.id
        seat2.viewer.id.should_not eq viewer1.id
      end
    end
  end
end
