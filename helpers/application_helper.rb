module ApplicationHelper
  def title(value = nil)
    @title = value if value
    @title ? "controller demo - #{@title}" : "controller demo"
  end

  def valid_key?(key)
    @current_user ||= User.find_by_token(key) unless key.nil?
  end

  def current_user
    @current_user ||= User.find_by_token(session[:user]) if session[:user]
  end

  def login?
    !session[:user].nil?
  end
end