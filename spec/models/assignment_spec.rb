require 'rails_helper'

RSpec.describe Assignment do
  it { is_expected.to have_attribute :points_earned }
  it { is_expected.to have_attribute :points_possible }
  it { is_expected.to have_attribute :order }
  it { is_expected.to have_attribute :due_at }
  it { is_expected.to have_attribute :completed_at }
  it { is_expected.to have_attribute :time_zone_id }

  it 'is late when due_at is after today and not completed' do
    subject.due_at = DateTime.new(2016, 1, 9)
    expect(Date).to receive(:today).and_return DateTime.new(2016, 1, 10)
    expect(subject.late?).to be true
  end

  it 'is not complete when no completion date is set' do
    expect(subject.complete?).to be false
  end

  it 'time_zone_id is a valid time_zone_id' do
    subject.time_zone_id = 'MarsTime'
    subject.valid?
    expect(subject.errors[:time_zone_id]).to include 'is not included in the list'
  end
end
