class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.integer :post_id, null:false
      t.timestamps null: false
    end
    add_index :tags, :post_id
  end
end
