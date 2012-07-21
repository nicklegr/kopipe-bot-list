class Bot < ActiveRecord::Base
  attr_accessible :account, :comment, :followers, :name, :user_id
end
