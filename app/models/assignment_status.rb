class AssignmentStatus
  NOT_STARTED = :not_started
  STARTED = :started
  DONE = :done
  PERFECT = :perfect

  EMPTY = 0
  HALF_FULL = 2
  FULL = 4

  attr_reader :class_assignment

  def initialize(class_assignment)
    @class_assignment = class_assignment
  end

  def status
    case class_assignment.number_graded
    when 0
      NOT_STARTED
    when class_assignment.possible_type_count
      if class_assignment.all_points_earned == class_assignment.possible_points
        PERFECT
      else
        DONE
      end
    else
      STARTED
    end
  end

  def overdue_status
    if class_assignment.overdue?
      'overdue'
    else
      ''
    end
  end

  def battery_level(progress: status)
    case progress
    when STARTED
      HALF_FULL
    when DONE, PERFECT
      FULL
    else
      EMPTY
    end
  end
end

