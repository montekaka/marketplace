class AddCategoryToPins < ActiveRecord::Migration
  def change
    add_column :pins, :category, :string
  end
end
