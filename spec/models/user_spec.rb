require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) } 
  it { should validate_uniqueness_of(:username) }
  it { should validate_presence_of(:password_digest)}

  context 'when signing up' do
    it 'shouldn\'t save the password' do
      user = FactoryBot.create(:user)
      expect(User.last.password).to eql(nil)
    end

    before(:each) do
      @user = FactoryBot.create(:user)
    end

    it 'should set the password digest' do
      expect(@user.password_digest).not_to eql(nil)
    end

    it 'should set a session_token' do
      expect(@user.session_token).not_to eql(nil)
    end
  end

  context 'when logging in' do
    it 'should return true if username and password match' do
      user = FactoryBot.create(:user, password: 'password')
      expect(User.find_by_credentials(user.username, 'password')).to be_a(User)
    end

    it 'should reset the session_token' do
      user = FactoryBot.create(:user)
      old_token = user.session_token
      user.reset_session_token
      new_token = user.session_token
      expect(old_token).to_not eql(new_token)
    end
  end
end
