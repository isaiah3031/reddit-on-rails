class CreateSubsPosts < ActiveRecord::Migration[6.0]
  def change
    create_join_table :posts, :subs  do |t|
      t.index :sub_id
      t.index :post_id
    end
  end
end
