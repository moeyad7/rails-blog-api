class RenameUserIdToAuthorIdInPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :user_id, :author_id
    # Update the foreign key constraint to refer to the correct column
    remove_foreign_key :posts, :users
    add_foreign_key :posts, :users, column: :author_id
  end
end
