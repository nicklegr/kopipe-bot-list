class Bot < ActiveRecord::Base
  attr_accessible :account, :comment, :followers, :name, :user_id

  def self.by_account(account)
    bot = new()

  	begin
      user = Twitter.user(account)
      bot.account = account
      bot.followers = user.followers_count
      bot.name = user.name
      bot.user_id = user.id
    rescue => e
      bot.errors.add(:account, "Invalid account '#{account}': #{e}")
    end

    bot
  end
end
