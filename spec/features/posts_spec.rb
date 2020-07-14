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
    scenario 'Users can create a post' do
      create_post(Sub.last)
      expect(Post.last.subs).to eql(Sub.last)
    end

    scenario 'Displays post after creation' do
      title = Faker::Lorem.sentence(word_count: 3)
      create_post(Sub.last, title)
      expect(page).to have_text(title)
    end
  end

  feature 'Displaying posts' do
    scenario 'Sub show page displays its posts' do
      titles = []
      2.times { titles << Faker::Lorem.sentence(word_count: 4)}
      titles.each{ |title| create_post(Sub.last, title)}
      visit sub_url(Sub.last.id)
      expect(page).to have_text(titles[0])
      expect(page).to have_text(titles[1])
    end
  end

  feature 'Editing posts' do
    scenario 'Authors can edit their own posts' do
      create_post(Sub.last)
      content = Faker::Lorem.sentence(word_count: 5)
      edit_last_post(content)
      expect(page).to have_text(content)
    end

    scenario 'Users can not edit the posts of others' do
      create_post(Sub.last)
      logout
      create_user(Time.now.to_s)
      visit '/posts/' + Post.last.id.to_s + '/edit'
      expect(page).not_to have_button('Edit Post')
      expect(page).to have_text('All Subs')
    end
  end
end
