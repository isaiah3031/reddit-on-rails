require 'rails_helper'
require './test/test_helpers/creation_helpers.rb'

include CreationHelpers

feature 'Displays subs' do
  scenario 'when logged out' do
    visit subs_url
    expect(page).to have_text('All Subs')
  end
end

feature 'Creating subs' do
  before(:each) do
    create_user(Time.now.to_s)
  end
  scenario 'Allows users to create subs' do
    visit subs_url
    expect(page).to have_link('', href: new_sub_url) 
    expect(page).to have_text('Create Sub')
  end

  scenario 'Users must log in before creating a sub' do
    visit subs_url
    expect(page).to have_link('', href: new_sub_url) 
    expect(page).to have_text('Create Sub')
    logout
    expect(page).not_to have_link('', href: new_sub_url)
    expect(page).not_to have_text('Create Sub')
  end

  scenario 'Displays the newly created sub' do
    new_sub_title = Faker::Lorem.sentence(word_count: 2)
    create_sub(new_sub_title)
    expect(page).to have_text(new_sub_title)
  end
end