require 'rails_helper'
require './test/test_helpers/creation_helpers.rb'
require './test/test_helpers/user_auth.rb'

include CreationHelpers
include SignInHelper

feature 'Viewing posts' do
  scenario 'The sub show page displays its posts' do
    create_user(Time.now)
    create_sub
    create_post
    debugger
    expect(page).to have_text(Post.last.title)
    expect(page).to have_text(Post.last.content)
    expect(page).to have_text(Sub.first.title)
  end
end
