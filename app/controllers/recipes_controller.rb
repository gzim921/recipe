class RecipesController < ApplicationController
  before_action :require_login, except: [:index, :show, :newest_recipe]
  before_action :admin_only, except: [:index, :show, :newest_recipe]
  before_action :set_recipe, except: [:index, :new, :create, :newest_recipe]

  def index
    @users = User.all
    @categories = Category.all
    @recipes = Recipe.all

    if !params[:name].blank?
      @recipes = Recipe.by_name(params[:name])
    elsif !params[:user].blank?
      @recipes = Recipe.by_user(params[:user])
    else
      @recipes = Recipe.all
    end
  end

  def new
    @recipe = Recipe.new
    5.times { @recipe.recipe_ingredients.build }
    2.times { @recipe.recipe_categories.build }
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def show
  end

  def edit 
  end

  def update
    recipe
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path
  end

  def newest_recipe
    @recipe = Recipe.newest.first
  end

  private
  
  def recipe_params
    params.require(:recipe).permit(:name, :cooking_time, :servings, :directions)
  end

  def set_recipe
    @recipe = Recipe.find_by_id(params[:id])
  end
end
