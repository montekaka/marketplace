class AddTitleToPins < ActiveRecord::Migration
  def change
    add_column :pins, :title, :string
    add_column :pins, :link, :string
  end
end
