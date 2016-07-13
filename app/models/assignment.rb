class Assignment < ActiveRecord::Base
  belongs_to :course, inverse_of: :assignments

  validates :time_zone_id,
            allow_blank: true,
            inclusion: {
              in: ActiveSupport::TimeZone.all.map { |tz| tz.tzinfo.identifier }
            }

  def late?
    !complete? && due_at < Date.today
  end

  def complete?
    completed_at.present?
  end
end
