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

  scenario 'Posts display comments belonging to them' do 
    create_comment
    expect(page).to have_text(Post.last.comments.last.content)
  end

  scenario 'Posts have a link to create parent comments' do
    expect(page).to have_link(href: new_post_comment_url(Post.last))
  end

  scenario 'Users can leave comments' do
    comment = Time.now.to_s
    create_comment(comment)
    expect(page).to have_text(comment)
  end

  scenario 'Blank comments are not allowed' do
    create_comment('override')
    expect(page).to have_text('Must contain a comment.')
  end

  scenario 'Parent comments link to their own show page' do
    create_comment
    visit post_url(Post.last)
    expect(page).to have_link('Expand', href: comment_url(Comment.last))
  end

  feature 'Child comments' do

    before(:each) do
      create_user(Faker::Name.name)
      create_sub
      create_post(Sub.last)
    end

    scenario 'Comments have a child comment creation link' do
      create_comment
      expect(page).to have_link(href: new_post_comment_url(Post.last))
    end

    scenario 'Comment show pages show child comments' do
      create_comment
      parent_comment = Comment.last
      click_on 'Expand'
      fill_in :content, with: "child"
      click_button 'Create'
      child_comment = Comment.last
      visit comment_url(parent_comment)
      expect(page).to have_text('child')
      expect(child_comment.parent_comment).to eql(parent_comment)
    end
  end
end
