require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:sub_id) }
  it { should validate_presence_of(:author_id) }

  it { should belong_to(:sub) }
  it { should belong_to(:author) }
end
