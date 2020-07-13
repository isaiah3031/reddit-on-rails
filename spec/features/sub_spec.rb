require 'rails_helper'

feature 'Displays subs' do
  scenario 'when logged out' do
    visit subs_url
    expect(page).to have_text('All Subs')
  end
end

feature 'Creating subs' do
  scenario 'Allows users to create subs' do
    create_user(Time.now.to_s)
    visit subs_url
    expect(page).to have_link('', href: new_sub_url) 
    expect(page).to have_text('Create Sub')
  end

  scenario 'Users must log in before creating a sub' do
    create_user(Time.now.to_s)
    visit subs_url
    expect(page).to have_link('', href: new_sub_url) 
    expect(page).to have_text('Create Sub')
    logout
    expect(page).not_to have_link('', href: new_sub_url)
    expect(page).not_to have_text('Create Sub')
  end
end