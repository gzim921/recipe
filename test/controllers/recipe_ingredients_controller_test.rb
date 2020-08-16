require 'test_helper'

class RecipeIngredientsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get recipe_ingredients_new_url
    assert_response :success
  end

end
