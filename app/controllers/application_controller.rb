class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :require_login

  helper_method :show_header?, :user_signed_in?, :current_user

  private

  def not_authenticated
    redirect_to login_path, alert: t("application.not_authenticated")
  end

  def show_header?
    ![ "sessions", "users" ].include?(controller_name) || ![ "new", "create" ].include?(action_name)
  end

  def user_signed_in?
    current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    unless current_user
      redirect_to login_path, alert: "ログインが必要です"
    end
  end
end
