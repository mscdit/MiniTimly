class AddNameToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :item_name, :string
  end
end
