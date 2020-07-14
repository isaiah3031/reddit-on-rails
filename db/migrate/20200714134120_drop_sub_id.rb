class DropSubId < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :sub_id
  end
end
