class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :require_login

  helper_method :show_header?

  private

  def not_authenticated
    redirect_to login_path, alert: t('application.not_authenticated')
  end

  def show_header?
    !['sessions', 'users'].include?(controller_name) || !['new', 'create'].include?(action_name)
  end
end
