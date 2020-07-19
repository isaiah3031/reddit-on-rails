require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:author_id) }

  it { should have_many(:comments) }
  it { should have_many(:posts_subs) }
  it { should have_many(:subs).through(:posts_subs) }
  it { should belong_to(:author) }

  describe 'Comments by parent id' do 
    it 'should return a hash where key = parent_ids and values = child_ids' do
      Rails.application.load_seed
      comment = Comment.last
      
      expect(Post.last.comments_by_parent_id[comment.parent_comment_id]).to eql(
        [
          { id: comment.id, parent_comment_id: comment.parent_comment_id, content: comment.content }
        ]
      )
    end
  end
end
