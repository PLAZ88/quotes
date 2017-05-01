class QuotesController < ApplicationController
  def show
  	@my_favorites = Favorite.where(user_id: current_user)
    @user = User.find(current_user.id)
    @quotes = Quote.where.not(id: @user.favorites.select(:quote_id))


  end

  def create
  	@quote = Quote.new(quote_params)
    if @quote.save
      redirect_to "/quotes/#{session[:user_id]}"
    else
      flash[:errors] = @quote.errors.full_messages
      redirect_to :back
    end
  end

  private

	def quote_params
	  params.require(:quote).permit(:quoted_by, :message).merge(user: current_user)
	end

end
