class ChangeApiKeyToBeUniqueInProfiles < ActiveRecord::Migration[7.0]
  def change
    change_column :profiles, :name, :string, unique: true
  end
end
