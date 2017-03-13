class UsersController < ApplicationController

skip_before_action :require_login, only: [:show, :index, :new, :create]

def index
end

def new
  @hide = true
  @user = User.new
end

def create
  @user = User.new(user_params)
    if @user.save
      login(params[:user][:email], params[:user][:password])
      redirect_to root_path
    else
      redirect_to root_path
      flash[:notice] = @user.errors.full_messages[0]
    end
end

def edit
  @hide = true
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
    @food = Food.new
    @list_items = @user.list_items.where(pantry: false).order(created_at: :desc)
    @list_mode = "list"
  else
    redirect_to login_path
  end
end
  #check if we still need :user_id anywhere in this controller
def update_list
  @food = Food.new
  @user = User.find(params[:user_id])
  @user.generate_suggestions
  redirect_to root_path
end

def remove_item
  #deletes the association from the join table
  @user = current_user
  @list = @user.list_items
  @list.delete(params[:format])
end

def clear_list
  # clears ALL associations between models
  @user = current_user
  @foods = @user.list_items.where(pantry: false)
  @foods.destroy_all
  redirect_to root_path
end

def clear_pantry
  # removes list item associations on all "pantry=true" items in user's list.
  @user = current_user
  @foods = @user.list_items.where(pantry: true)
  @foods.destroy_all
  redirect_to user_pantry_show_path
end

def pantry
  @list_item = ListItem.find(params[:format])
  if @list_item.pantry == false
    @list_item.pantry = true
  else
    @list_item.pantry = false
  end
  @list_item.save
end

def pantry_show
  if current_user
    @user = User.find(current_user)
    @food = Food.new
    @list_items = @user.list_items.where(pantry: true)
    @list_mode = "pantry"
  else
    redirect_to new_user_path
  end
end

def add_back
  @list_item = ListItem.find(params[:format])
  @list_item.pantry = false
  @list_item.save
end

private
  def user_params
    params.require(:user).permit( :name,
                                  :email,
                                  :password,
                                  :id,
                                  :user_id,
                                  :vegan,
                                  :veg,
                                  :pescatarian,
                                  :gluten_free,
                                  :dairy_free,
                                  :nut_free,
                                  :weight_kg,
                                  :activity_level,
                                  :date_of_birth
                                  )
  end
end
