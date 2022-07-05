require 'rails_helper'

describe User do
  before(:each) do
    @user = create(:user)
  end

  it "should create a new instance of a user given valid attributes" do
    User.create!(@user.attributes)
  end
end