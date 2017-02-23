class Student < User
  has_many :student_classes
  has_many :class_periods, through: :student_classes

  def display_name
    nickname || "#{last_name}, #{first_name}"
  end

  def graduation_year
    @graduation_year ||= parse_graduation_year_from_email
  end

  def parse_graduation_year_from_email
    Date.today.year.to_s.first(2) + email.split('@').first.last(2)
  end
end
