class CurrentUnitSelector
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def select(class_period: user.class_periods.first)
    unit_from_prefs(class_period).presence || default_unit(class_period)
  end

  private

  def unit_from_prefs(class_period)
    case user
    when Teacher
      user.settings(:prefs).current[:"#{class_period.id}"]
    when Student
      user.settings(:prefs).current
    end
  end

  def default_unit(class_period)
    class_period.units.visible&.first&.id
  end
end
