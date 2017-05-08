class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = Notification.where(user_id: current_user.id).where(read: false).order(created_at: :desc) #自分の通知のみ取得し、未読のみ表示にし、降順にすることで最新のが上に表示されるようにする
  end
end
