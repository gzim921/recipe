require 'rails_helper'

RSpec.describe 'Recipes' do
  describe 'Creating an recipe' do
    context 'when no user is logged in' do
      it 'redirects back to login path' do
        post_params = {
          params: {
            recipe: {
            name: 'Log In'
            }
          }
        }
        post '/recipes', post_params
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq 'Please login'
      end
    end
  end

  describe 'Editing an recipe' do
    context "when the recipe's user is the same as the logged in User" do
      let(:user) { create(:user) }
      let(:recipe) { create(:recipe, user: user) }

      it 'can edit the recipe' do
        get root_path
        within('form') do
          click_on 'Login'
        end

        get '/login'
        expect(response).to have_http_status(:ok)

        post_params = {
          params: {
            user: {
              email: user.email,
              password: user.password
            }
          }
        }

        within('form') do
          fill_in 'Email', with: user.email
          fill_in 'Password', with: user.password
          click_on 'Login'
        end

        post '/login', post_params
        get "/users/#{user.id}"

        # follow_redirect!

        # expect(flash[:success]).to eq "Welcome #{user.name} !!!"
        get "/recipes"
        expect(response).to have_http_status(:ok)

        get "/recipes/#{recipe.id}"
        expect(response).to have_http_status(:ok)

        get "/recipes/#{recipe.id}/edit"
        patch_params = {
          params: {
            recipe: {
              name: recipe.name,
              cooking_time: 2,
              servings: 2,
              directions: recipe.directions
            }
          }
        }

        patch "/recipes/#{recipe.id}", patch_params
        expect(response).to have_http_status(:found)

      end
    end
  end

    context "when the recipe's user is different then the logged in User" do
      let(:user) { create(:user) }
      let(:other_user) { create(:user) }
      let(:recipe) { create(:recipe, user: other_user) }

      it 'redirect back when GET edit' do
        get '/login'
        post_params = {
          params: {
            user: {
              email: user.email,
              password: user.password
            }
          }
        }
        post '/login', post_params
        follow_redirect!

        get "/recipes/#{recipe.id}/edit"

        # expect(flash[:error]).to eq 'Login info was incorrect. Please try again.'
        # expect(response).to redirect_to(root_path)
      end

    it 'redirect back when PATCH edit' do
      post_params = {
        params: {
            user: {
              email: user.email,
              password: user.password
            }
          }
        }
        post '/login', post_params
        follow_redirect!


        patch "/recipes/#{recipe.id}"

      end
    end

    context "when the recipe's user is different on the logged in User" do
      let(:user) { create(:user) }
      let(:current_user) { create(:user) }
      let(:recipe) { create(:recipe, user: current_user) }

      it 'redirect back to root path' do
        post_params = {
          params: {
            user: {
              email: user.email,
              password: user.password
            }
          }
        }
        post '/login', post_params
        follow_redirect!

        delete "/recipes/#{recipe.id}"
      end
    end

  context 'when no user is logged in' do
    let(:recipe) { create(:recipe) }

    it 'redirect back to root path' do
    delete "/recipes/#{recipe.id}"

    expect(response).to redirect_to(root_path)
    end
  end
end
