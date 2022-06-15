class RemoveFieldNameFromItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :items, :item_name, :string
  end
end
