require 'rails_helper'

describe User do
  before(:each) do
    @user = create(:user)
  end

  it 'should create the example user with correct email' do
    expect(@user.email).to eq 'user4@example.com'
  end
end
