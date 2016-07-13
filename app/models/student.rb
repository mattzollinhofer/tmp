class Student < User
  has_many :student_classes
  has_many :class_periods, through: :student_classes

  validates :graduation_year, presence: true,
                              inclusion: {
                                in: Date.today.year..(Date.today + 30.years).year,
                                message: 'must be between this year and 30 years from now'
                              },
                              numericality: {only_integer: true},
                              format:{
                                with: /20\d{2}/i,
                                message: 'must be a four digit year'
                              }
  def display_name
    nickname || first_name
  end
end
