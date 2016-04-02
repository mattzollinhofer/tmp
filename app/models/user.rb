class User < ActiveRecord::Base
  has_many :students

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email_address, presence: true, uniqueness: true
  validates :mobile_number, uniqueness: true
end
