require 'rails_helper'

RSpec.describe SubsController, type: :controller do
  describe 'GET #index' do
    it 'renders the index page' do
      get :index
      expect(response).to render_template('index')
      expect(response).to have_http_status(200)
    end
  end
end
