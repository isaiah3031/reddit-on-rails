require 'rails_helper'

RSpec.describe PostsSub, type: :model do
  it { should validate_presence_of(:sub_id) }
  it { should validate_presence_of(:post) }
  it { should belong_to(:post) }
  it { should belong_to(:sub) }

  FactoryBot.create(:user)
  FactoryBot.create(:sub, moderator_id: User.last.id)
  post = FactoryBot.build(:post, author_id: User.last.id, sub_ids: Sub.last.id)
  relation = PostsSub.new(post: post)
  post.save
  it { should validate_uniqueness_of(:sub_id).scoped_to(:post_id) }
end
