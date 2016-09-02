class Unit < ActiveRecord::Base
  belongs_to :course, inverse_of: :units
  has_many :assignments, inverse_of: :unit
  after_initialize :default_order

  def default_order
    return nil if course.blank?
    return order if order.present?

    self.order = course.units.length + 1
  end

  def to_s
    name
  end
end
