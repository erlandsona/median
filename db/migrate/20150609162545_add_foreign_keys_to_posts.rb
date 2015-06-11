class AddForeignKeysToPosts < ActiveRecord::Migration
  def change
    add_foreign_key(:posts, :users, column: :author_id)
  end
end