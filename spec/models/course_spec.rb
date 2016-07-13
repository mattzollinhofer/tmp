require 'rails_helper'

RSpec.describe Course do
  it { is_expected.to have_attribute :name }
  it { validate_presence_of :name }

  it { is_expected.to have_many :assignments }

  describe 'to_s' do
    let (:brian)   { FactoryGirl.build_stubbed(:teacher) }
    let (:christi)   { FactoryGirl.build_stubbed(:teacher) }
    let (:subject) { Course.new(name: 'Math 100') }
    it 'should print a friendly version of itself' do
      expect(subject.to_s).to eq "Math 100"
    end
  end
end
