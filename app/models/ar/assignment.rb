class Assignment < ActiveRecord::Base
  default_scope { order(order: :asc)  }

  has_many :class_assignments, dependent: :destroy
  belongs_to :unit, inverse_of: :assignments
  after_initialize :default_order

  scope :possible_points_for_assignment, -> (assignment) do
    assignment.possible_points
  end

  def default_order
    return nil if unit.blank?
    return order if order.present?

    self.order = unit.assignments.length + 1
  end

  def possible_points
    notes_points_possible + ixl_points_possible + worksheet_points_possible + star_points_possible
  end

  def due_at
    if attributes['due_at'].present?
      attributes['due_at'].strftime('%m/%d/%Y')
    else
      super
    end
  end

  def due_at= date
    return if date.blank?
    write_attribute :due_at, Date.strptime(date, "%m/%d/%Y")
  end

  def class_periods
    unit.course.class_periods
  end

  def worksheet_points_possible
    self[:worksheet_points_possible] || 0
  end

  def star_points_possible
    self[:star_points_possible] || 0
  end

  def ixl_points_possible
    self[:ixl_points_possible] || 0
  end

  def notes_points_possible
    self[:notes_points_possible] || 0
  end

  def possible_type_count
    [worksheet_points_possible, ixl_points_possible, notes_points_possible, star_points_possible]
      .reject{|points| points == 0}.compact.size
  end

  validates :order, :name, presence: true
  #TODO move to student_class
  #validates :time_zone_id,
  #          allow_blank: true,
  #          inclusion: {
  #            in: ActiveSupport::TimeZone.all.map { |tz| tz.tzinfo.identifier }
  #          }

  #def late?
  #  !complete? && due_at < Date.today
  #end

  #def complete?
  #  completed_at.present?
  #end
end
