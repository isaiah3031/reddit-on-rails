require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    it 'renders the login page' do
      get :new
      expect(response).to render_template('new')
      expect(response).to have_http_status(200)
    end
  end

  context 'logging in with invalid params' do
    it 'validates the presence of username and password' do
      post :create, params: { user: { username: Time.now.to_s } }
      expect(response).to render_template('new')
      expect(flash[:errors]).to be_present
    end
  end

  context 'logging in with valid params' do
    it 'redirects to the show page' do
      FactoryBot.create(:user, username: 'testuser', password: 'password')
      post :create, params: { user: { username: 'testuser', password: "password" }}
      expect(response).to redirect_to(user_url(User.find_by(username: 'testuser')))
    end
  end

  context 'logging out' do
    it 'redirects to the Sub Index page' do
      FactoryBot.create(:user)
      delete :destroy, params: { id: User.last.id }
      expect(response).to redirect_to(subs_url)
    end
  end
end
