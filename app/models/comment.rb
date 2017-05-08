class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :blog
  has_many :notifications, dependent: :destroy #コメントを削除した場合、通知も削除する
end
