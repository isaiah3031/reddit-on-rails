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

  scenario 'Post display comments belonging to it' do
    expect(page).to have_link(href: new_post_comment_url(Post.last))
  end

  scenario 'Users can leave comments' do
    comment = Time.now.to_s
    create_comment(comment)
    expect(page).to have_text(comment)
  end

  scenario 'Parent comments link to their own show page' do
    create_comment
    visit post_url(Post.last)
    expect(page).to have_link('Expand', href: comments_url(Comment.last))
  end
end

