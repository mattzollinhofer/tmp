require 'rails_helper'

RSpec.describe Course do
  it { is_expected.to have_attribute :name }
  it { is_expected.to have_many :students }
end
