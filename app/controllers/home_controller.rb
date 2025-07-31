class HomeController < ApplicationController
  skip_before_action :require_login
  def index
    # topページのロジックをここに追加できます
  end
end
