class AddForeignKeyToComments < ActiveRecord::Migration
  def change
    add_foreign_key(:comments, :users, column: :author_id)
  end
end
