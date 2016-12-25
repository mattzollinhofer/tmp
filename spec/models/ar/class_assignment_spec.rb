require 'spec_helper'

describe ClassAssignment do
  it { is_expected.to have_attribute :completed_at }
  it { is_expected.to have_attribute :points_earned }
  it { is_expected.to have_attribute :stars_earned }

  it { is_expected.to belong_to :student_class }
  it { is_expected.to belong_to :assignment}
end
