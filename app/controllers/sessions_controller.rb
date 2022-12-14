# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new; end

  def create
    user = User.find_by(email: login_params[:email])
    if user&.authenticate(login_params[:password])
      session[:current_user_id] = user.id
      # render plain: 'Success'
      redirect_to '/home'
      # redirect_to home_path
    else
      flash[:error] = 'Invalid email or password!'
      render plain: 'Fail'
      # redirect_to "/signin"
      #   flash[:error] = "Your signin attempt was invalid, Please retry."
      #   redirect_to new_sessions_path
    end
  end

  def destroy
    session[:current_user_id] = nil
    @current_user = nil
    redirect_to '/'
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
