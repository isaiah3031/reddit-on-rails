require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:post_id) }
  it { should validate_presence_of(:author_id) }
  it { should belong_to(:parent_comment).optional }
  it { should belong_to(:author) }
  it { should belong_to(:post) }
  it { should belong_to(:child_comment).optional }

  describe 'latest_child method' do
    it 'should return the latest child of a comment' do
      Rails.application.load_seed
      user = User.find_by(username: 'big_moderator')
      first_comment = user.comments.first
      latest_child = Comment.find_by(content: 'child9')
      expect(first_comment.latest_child).to eql(latest_child)
    end
  end
end

