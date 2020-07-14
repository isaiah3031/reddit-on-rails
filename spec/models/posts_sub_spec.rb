require 'rails_helper'

RSpec.describe PostsSub, type: :model do
  it { should validate_presence_of(:sub_id) }
  it { should validate_presence_of(:post_id) }
  it { should belong_to(:post) }
  it { should belong_to(:sub) }

  FactoryBot.create(:user)
  FactoryBot.create(:sub, moderator_id: User.last.id)
  FactoryBot.create(:post, author_id: User.last.id, sub_ids: Sub.last.id)
  it { should validate_uniqueness_of(:sub_id).scoped_to(:post_id) }
end
