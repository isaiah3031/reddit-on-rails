module CreationHelpers
  def create_sub(title = nil)
    title = Faker::Lorem.sentence(word_count: 2) if title.nil?
    visit '/subs/new'
    fill_in 'title', with: title
    fill_in 'description', with: Faker::Lorem.sentence(word_count: 8, supplemental: true)
    click_on 'Create'
  end

  def edit_last_sub(description)
    link = '/subs/' + Sub.last.id.to_s + '/edit'
    visit link
    fill_in 'description', with: description
    click_on 'Edit'
  end
end
