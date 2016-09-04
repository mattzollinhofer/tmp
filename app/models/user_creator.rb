class UserCreator
  def self.from_omniauth(access_token)
    data = access_token.info
    email = data[:email]
    user = User.where(email: email).first

    unless user
      user = user_class_from_email(email).new(user_attributes(data))
    end

    user
  end

  private

  def self.user_attributes(data)
    {
      first_name: data['first_name'],
      last_name: data['last_name'],
      email: data['email'],
      password: Devise.friendly_token[0,20]
    }
  end

  def self.user_class_from_email email
    (email =~ /.*[0-9][0-9]@.*?/) ? Student : Teacher
  end
end
