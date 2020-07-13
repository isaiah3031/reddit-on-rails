# I ran into some trouble here with the log in logic and it seems like
# it might be a better use of my time to just do feature tests? 

# Feature tests can encompass all I would do here and there seems to be a 
# general concensous in internet forums that integration tests are cumbersome
# and not always worth the effort.

# Another thing worth noting is that integration tests are just tests that
# touch more than one part of the framework. Testing all three at once, like
# what was going to happen here, can be easily done via capybara.

# require 'rails_helper'
# require './test/test_helpers/user_auth.rb'

# RSpec.describe SubsController, type: :controller do
#   include SignInHelper

#   describe 'GET #index' do
#     it 'renders the index page' do
#       get :index
#       expect(response).to render_template('index')
#       expect(response).to have_http_status(200)
#     end
#   end

#   describe 'GET #new' do
#     it 'renders the new page' do
#       get :new
#       expect(response).to render_template('new')
#       expect(response).to have_http_status(200)
#     end

#     context 'when not logged in' do
#       it 'renders the login page' do
#         post :create, params: { sub: {title: Time.now.to_s, description: '' }}
#         expect(response).to redirect_to(new_session_url)
#       end
#     end
#     context 'when logged in' do
#       it 'renders the subs show page' do
#         create_and_sign_in(Time.now.to_s)
#         post :create, params: { sub: {title: Time.now.to_s, description: '', moderator_id: 2}}
#         debugger
#         expect(response).to redirect_to(sub_url(Sub.last.id))
#       end
#     end
#   end
# end
