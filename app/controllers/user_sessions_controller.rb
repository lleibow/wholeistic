class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]


 def new
   @hide = true
    @user = User.new
  end

 def create
    if @user = login(params[:email], params[:password])
      # redirect_back_or_to(:users, notice: 'Login successful')
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

 def destroy
    logout
    # redirect_to(:users, notice: 'Logged out!')
    redirect_to new_user_session_path
  end
end
