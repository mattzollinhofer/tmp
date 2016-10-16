class Course < ActiveRecord::Base
  has_many :units, inverse_of: :course
  has_many :class_periods, inverse_of: :course

  validates :name, presence: true
  validates :year,
             inclusion: {
                in: 1900..Date.today.year+50,
                message: 'should be a four-digit year'
             },
             format: {
               with: /\d{4}/i,
               message: 'should be a four-digit year'
             }

  def year
    self[:year] || default_course_year
  end

  def to_s
    "#{name} (#{display_year})"
  end

  def total_assignments
    @total_assignments = 0
    units.each{ |unit| @total_assignments += unit.assignments.size }
    @total_assignments
  end

  private

  def display_year
    "#{year}-#{year+1}"
  end

  def default_course_year
    Time.now.year
  end

end
