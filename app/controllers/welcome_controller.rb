class WelcomeController < ApplicationController
  def index
    @welcome = "#{current_user.type}Welcome".constantize.new current_user
    render "welcome/#{current_user.type.downcase}"
  end
end
