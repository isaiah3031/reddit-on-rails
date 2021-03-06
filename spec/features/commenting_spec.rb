require 'rails_helper'
require './test/test_helpers/creation_helpers.rb'
require './test/test_helpers/user_auth.rb'

feature 'Comments' do
  include SignInHelper
  include CreationHelpers

  feature 'Post show page' do
    before(:each) do
      create_user(Faker::Name.name)
      create_sub
      create_post(Sub.last)
    end

    scenario 'displays parent comments belonging to them' do 
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
      button = page.find('#expand')
      expect(button).not_to eql(nil)
    end
  end

  feature 'Child comments' do
    before(:each) do
      create_user(Faker::Name.name)
      create_sub
      create_post(Sub.last)
    end

    scenario 'Comments have a child comment creation link' do
      create_comment
      button = page.find('#expand', match: :first)
      expect(button).not_to eql(nil)
    end

    before(:each) do
      create_comment
      @parent_comment = Comment.last
      within ('.comment-chain') do
        within ('li') do
          click_on 'expand'
        end
      end 
      within ('form') do
        fill_in :content, with: 'child'
      end
      click_button
      @child_comment = Comment.last
    end

    scenario 'Post show page displays one child comment' do
      visit post_url(@parent_comment.post_id)
      expect(page).to have_text(@child_comment.content)
      expect(@child_comment.parent_comment).to eql(@parent_comment)
    end

    scenario 'Comment show pages show child comments' do
      within ('.comment-chain') do
        within first('li') do
          click_on 'expand'
        end
      end
      fill_in :content, with: 'child2'
      click_button
      visit comment_url(@parent_comment)
      expect(page).to have_text('child')
      expect(page).to have_text('child2')
    end

    scenario 'Users can create child comments' do
      expect(@child_comment.parent_comment).to eql(@parent_comment)
    end
  end
end
