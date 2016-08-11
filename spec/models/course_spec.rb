require 'rails_helper'

RSpec.describe Course do
  it { is_expected.to have_attribute :name }
  it { validate_presence_of :name }
  it do
    should validate_inclusion_of(:year)
             .in_range(1900..Date.today.year+50)
             .with_message('should be a four-digit year')
  end

  it { is_expected.to have_many :units }

  describe 'to_s' do
    let (:brian)   { FactoryGirl.build_stubbed(:teacher) }
    let (:christi)   { FactoryGirl.build_stubbed(:teacher) }
    let (:subject) { Course.new(name: 'Math 100', year: 1999) }

    it 'should print a friendly version of itself' do
      expect(subject.to_s).to eq "Math 100 (1999-2000)"
    end
  end

  describe 'year' do
    it 'defaults to the current year' do
      expect(subject.year).to eq Time.now.year
    end
  end
end
