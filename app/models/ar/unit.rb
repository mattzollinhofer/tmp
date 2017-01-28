class Unit < ApplicationRecord
  default_scope { order(order: :asc)  }

  belongs_to :course, inverse_of: :units
  has_many :assignments, inverse_of: :unit, dependent: :destroy
  after_initialize :default_order

  def default_order
    return nil if course.blank?
    return order if order.present?

    self.order = course.units.length + 1
  end

  def possible_points
    assignments.map(&:possible_points).sum || 0
  end

  def to_s
    name
  end
end
