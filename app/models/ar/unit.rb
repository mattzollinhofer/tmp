class Unit < ApplicationRecord
  default_scope { order(order: :asc)  }

  scope :visible, -> { where(visible: true) }
  belongs_to :course, inverse_of: :units
  has_many :assignments, inverse_of: :unit, dependent: :destroy
  after_initialize :default_order

  def default_order
    return order if order.present?
    return nil if course.blank?

    self.order = course.units.length + 1
  end

  def possible_points
    assignments.map(&:possible_points).sum || 0
  end

  def to_s
    name
  end
end
