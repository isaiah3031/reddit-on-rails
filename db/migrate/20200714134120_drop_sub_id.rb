class DropSubId < ActiveRecord::Migration[6.0]
  def change
    drop_column :posts, :sub_id
  end
end
