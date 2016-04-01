class Assignment < ActiveRecord::Base
  def late?
    !complete? && due_at < Date.today
  end

  def complete?
    completed_at.present?
  end
end
