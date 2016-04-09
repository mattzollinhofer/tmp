require 'rails_helper'

RSpec.describe Teacher do
  it { is_expected.to belong_to :user }
end
