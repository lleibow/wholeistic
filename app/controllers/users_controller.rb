class UsersController < ApplicationController

 skip_before_action :require_login, only: [:show, :index, :new, :create]

 def index
 end
 
 def new
    @user = User.new
  end

 def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

 def edit
    @user = User.find(current_user)
  end

 def update
    @user = User.find(current_user)
    if @user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

 def destroy
  end

 def show
    if current_user
      @user = User.find(current_user)
      # @list = User.foods.all
    else
      redirect_to new_user_path
    end
  end
  #check if we still need :user_id anywhere in this controller
  def update_list
    @user = User.find(params[:user_id])
    @user.suggestion_noted
    redirect_to list_path(@user)
  end

 private
  def user_params
      params.require(:user).permit( :name,
                                    :email,
                                    :password,
                                    :id,
                                    :user_id)
    end
end
