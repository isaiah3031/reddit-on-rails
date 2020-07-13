require 'rails_helper'
require './test/test_helpers/creation_helpers.rb'
require './test/test_helpers/user_auth.rb'

include CreationHelpers
include SignInHelper

feature 'Creating posts' do
  scenario 'Users can create a post' do
    create_user(Time.now)
    create_sub
    create_post(Sub.last)
    expect(Post.last.sub).to eql(Sub.last)
  end

  scenario 'Displays post after creation' do
    create_user(Time.now)
    create_sub
    title = Faker::Lorem.sentence(word_count: 3)
    create_post(Sub.last, title)
    expect(page).to have_text(title)
  end
end

