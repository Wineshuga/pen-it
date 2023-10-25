class AddAuthorRefToPost < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :author_id, :string
    add_reference :posts, :author_id, null: false, foreign_key: {to_table: :users}
    add_index :posts, :author_id
  end
end
