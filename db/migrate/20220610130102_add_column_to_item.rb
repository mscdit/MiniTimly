class AddColumnToItem < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :brand, :string
  end
end
