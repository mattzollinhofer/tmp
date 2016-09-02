class Assignment < ActiveRecord::Base
  belongs_to :unit, inverse_of: :assignments
  after_initialize :default_order

  def default_order
    return nil if unit.blank?
    return order if order.present?

    self.order = unit.assignments.length + 1
  end


  validates :order, :name, presence: true
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
