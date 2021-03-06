class RatingsController < ApplicationController
  before_action :require_login

  def new
    @rating = Rating.new
  end

  def create
    @rating = current_user.ratings.build(rating_params)
    if @rating.save
      redirect_to recipe_path(@rating.recipe)
    else
      render :new
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:recipe_id, :score)
  end
end
