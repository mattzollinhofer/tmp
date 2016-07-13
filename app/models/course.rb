class Course < ActiveRecord::Base
  has_many :assignments, inverse_of: :course
  has_many :class_periods, inverse_of: :course

  validates :name, presence: true

  def to_s
    "#{name}"
  end
end
