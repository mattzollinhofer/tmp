class Unit < ActiveRecord::Base
  default_scope { order(order: :asc)  }

  belongs_to :course, inverse_of: :units
  has_many :assignments, inverse_of: :unit, dependent: :destroy
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
