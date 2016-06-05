class Student < ActiveRecord::Base
  belongs_to :user
  has_many :student_courses
  has_many :courses, through: :student_courses

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
    nickname || user.first_name
  end
end
