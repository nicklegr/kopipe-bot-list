class ChangeUserIdToLong < ActiveRecord::Migration
  def up
    change_column :bots, :user_id, :integer, :limit => 8
  end

  def down
    change_column :bots, :user_id, :integer
  end
end
