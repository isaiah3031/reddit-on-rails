require 'rails_helper'

RSpec.describe Sub, type: :model do
  it { should validate_presence_of(:moderator_id)}
  it { should belong_to(:moderator) }
  it { should have_many(:posts) }
  
end

