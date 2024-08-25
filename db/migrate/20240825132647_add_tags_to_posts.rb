class AddTagsToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :tags, :text, array: true, default: []
  end
end
