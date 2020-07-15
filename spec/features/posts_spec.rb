require 'rails_helper'
require './test/test_helpers/creation_helpers.rb'
require './test/test_helpers/user_auth.rb'


feature 'Posts' do
  include CreationHelpers
  include SignInHelper

  before(:each) do
    create_user(Time.now)
    create_sub
  end

  feature 'Creating posts' do
    scenario 'Must Log in to create a post' do
      logout
      visit '/subs/' + Sub.last.id.to_s + '/posts/new'
      expect(page).to have_text("Must log in.")
    end

    scenario 'Users can create a post with valid params' do
      create_post(Sub.last)
      expect(Post.last.subs.first).to eql(Sub.last)
    end

    # When create_post is passed the string 'override' the title is set
    # to nil. This should not create a post.
    scenario 'Users can not create a post with invalid params' do
      create_post(Sub.last, 'override')
      expect(Post.last.title).not_to eql('override')
      expect(page).to have_text('Invalid post. Please try again.')
    end

    scenario 'Displays post after creation' do
      title = Faker::Lorem.sentence(word_count: 3)
      create_post(Sub.last, title)
      expect(page).to have_text(title)
    end
  end

  feature 'Displaying posts' do
    before(:each) do
      @titles = []
      2.times { @titles << Faker::Lorem.sentence(word_count: 4)}
      @titles.each{ |title| create_post(Sub.last, title)}
      visit sub_url(Sub.last.id)
    end
    scenario 'Subs displays posts belonging to it' do
      expect(page).to have_text(@titles[0])
      expect(page).to have_text(@titles[1])
    end

    scenario 'Posts link you to their show page' do
      expect(page).to have_link(href: post_url(Post.find_by(title: @titles[0])))
      expect(page).to have_link(href: post_url(Post.find_by(title: @titles[1])))
    end
  end

  feature 'Editing posts' do
    scenario 'Authors can edit their own posts' do
      create_post(Sub.last)
      content = Faker::Lorem.sentence(word_count: 5)
      edit_last_post(content)
      expect(page).to have_text(content)
    end

    scenario 'Users can edit the sub associations of a post' do
      create_post(Sub.last)
      create_sub
      new_sub = "#subID[value='#{Sub.last.id.to_s}']"
      visit '/posts/' + Post.last.id.to_s + '/edit'
      find(:css, new_sub).set(true)
      click_on 'Edit Post'
      expect(Post.last.subs).to include(Sub.last)
    end

    scenario 'Users can not edit the posts of others' do
      create_post(Sub.last)
      logout
      create_user(Time.now.to_s)
      visit '/posts/' + Post.last.id.to_s + '/edit'
      expect(page).not_to have_button('Edit Post')
      expect(page).to have_text('You aren\'t authorized to do this.')
    end
  end
end
