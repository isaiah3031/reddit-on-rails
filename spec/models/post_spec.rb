require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:author_id) }

  it { should have_many(:comments) }
  it { should have_many(:posts_subs) }
  it { should have_many(:subs).through(:posts_subs) }
  it { should belong_to(:author) }
end
