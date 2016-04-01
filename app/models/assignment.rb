class Assignment < ActiveRecord::Base
  validates :time_zone_id, inclusion: { in: ActiveSupport::TimeZone.all.map { |tz| tz.tzinfo.identifier } }, allow_blank: true

  def late?
    !complete? && due_at < Date.today
  end

  def complete?
    completed_at.present?
  end
end
