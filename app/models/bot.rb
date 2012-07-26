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
    rescue
      bot.errors.add(:account, "Invalid user #{account}")
    end

    bot
  end
end
