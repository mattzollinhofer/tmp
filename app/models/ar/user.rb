class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :lockable, :omniauthable, :omniauth_providers => [:google_oauth2]

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates_inclusion_of :admin, in: [true, false]

  has_settings do |s|
    s.key :prefs, :defaults => { current: {} }
  end

  def name
    "#{first_name} #{last_name}"
  end

  def to_s
    display_user = name
    display_user += nickname.present? ? " (#{nickname})" : ''
    display_user += " - #{email.downcase}"
  end
end
