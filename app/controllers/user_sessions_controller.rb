class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]


 def new
    @user = User.new
  end

 def create
    if @user = login(params[:email], params[:password])
      # redirect_back_or_to(:users, notice: 'Login successful')
      redirect_to root_path
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new'
    end
  end

 def destroy
    logout
    # redirect_to(:users, notice: 'Logged out!')
    redirect_to root_path
  end
end
