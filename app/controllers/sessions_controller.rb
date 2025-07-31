class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    user = login(params[:email], params[:password])
    
    if user
      redirect_to root_path, notice: t('sessions.create.success')
    else
      flash.now[:alert] = t('sessions.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: t('sessions.destroy.success')
  end
end
