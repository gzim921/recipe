require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    it "creates a User and redirects to the User's page" do
      get '/signup'
      post_params = {
        params: {
          user: {
            first_name: 'Gzim',
            last_name: 'Iseni',
            user_name: 'gzim322',
            email: 'test@test.com',
            password: '123456',
            password_confirmation: '123456'
          }
        }
      }
      post '/users', post_params
      expect(session[:user_id]).not_to be_nil
      follow_redirect!
      expect(response.body).to include('Gzim')
      expect(response.body).to include('Iseni')
      expect(response.body).to include('gzim322')
    end
  end

  it 'renders New when User params are empty' do
    get '/signup'
    post_params = {
      params: {
        user: {
          first_name: '',
          last_name: '',
          user_name: '',
          email: '',
          password: '',
          password_confirmation: ''
        }
      }
    }
    post '/users', post_params
    expect(session[:user_id]).to be_nil
    expect(response.body).to include('Sign Up')
  end
end
