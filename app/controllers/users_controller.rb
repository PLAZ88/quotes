class UsersController < ApplicationController

  skip_before_action :require_login, only: [:create, :index]
  def index
  end

  def create
	  	@user = User.new(user_params)
	    if @user.save
	      session[:user_id] = @user.id
	      redirect_to "/quotes/#{session[:user_id]}"
	    else
	      flash[:errors] = @user.errors.full_messages
	      redirect_to :back
	    end
  end

  def show
    @user = User.find(current_user)
    @quotes = Quote.where(user_id: params[:id])
  end


  private

    def user_params
      params.require(:user).permit(:first_name, :alias, :email, :password, :password_confirmation)
    end

end
