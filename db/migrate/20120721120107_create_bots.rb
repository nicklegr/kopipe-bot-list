class CreateBots < ActiveRecord::Migration
  def change
    create_table :bots do |t|
      t.string :account
      t.integer :user_id
      t.string :name
      t.integer :followers
      t.text :comment

      t.timestamps
    end
  end
end
