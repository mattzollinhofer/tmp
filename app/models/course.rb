class Course < ActiveRecord::Base
  default_scope { order(year: :asc)  }

  has_many :units, inverse_of: :course, dependent: :destroy
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

  after_initialize :default_year

  def default_year
    return year if year.present?

    self.year = Time.now.year
  end

  def to_s
    "#{name} (#{display_year})"
  end

  def assignments
    return @assignments if @assignments

    @assignments = []
    units.each{ |unit| @assignments += unit.assignments }
    @assignments
  end

  def total_assignments
    return @total_assignments if @total_assignments

    @total_assignments = 0
    units.each{ |unit| @total_assignments += unit.assignments.size }
    @total_assignments
  end

  private

  def display_year
    "#{year}-#{year+1}"
  end
end
