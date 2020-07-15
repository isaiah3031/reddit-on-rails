require 'rails_helper'
require './test/test_helpers/creation_helpers.rb'
require './test/test_helpers/user_auth.rb'

feature 'Comments' do
  include SignInHelper
  include CreationHelpers

  before(:each) do
    create_user(Faker::Name.name)
    create_sub
    create_post(Sub.last)
  end

  scenario 'Link to comment creation from post pages' do
    expect(page).to have_link(href: new_post_comment_url(Post.last))
  end

  scenario 'Users can leave comments' do
    comment = Faker::Lorem.sentence(word_count: 15)
    click_on 'Leave a Comment'
    fill_in 'comment', with: comment
    click_on 'Comment'
    expect(page).to have_text(comment)
  end
end
