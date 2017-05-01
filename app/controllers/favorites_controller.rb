class FavoritesController < ApplicationController


  def create
    Favorite.create(favorite_params)
    redirect_to "/quotes/#{session[:user_id]}"
  end

  def destroy
    @favorite = Favorite.find(params[:id]).destroy
    redirect_to "/quotes/#{session[:user_id]}"
  end
  
  private
    def favorite_params
      params.require(:favorite).permit(:quote_id).merge(user: current_user)
    end

end
