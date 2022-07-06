require 'rails_helper'

describe Item do
  before(:each) do
    @user = create(:user)
  end

  it 'tests the default example item' do
    @item = create(:item)

    expect(@item.brand).to eq 'Apple'
  end

  it 'should not allow blank name attributes to be valid' do
    @item = build(:item, name: '')

    expect(@item.save).to eq false
  end
end
