# encoding: utf-8

class UsersController < ApplicationController
  before_action :authenticate

  def retire

  end

  def destroy
    if current_user.destroy
      reset_session
      redirect_to root_path, notice: '退会処理が完了しました'
    else
      render :retire
    end
  end

  def notifications
    notifications = current_user
                      .notifications
                      .limit(100)
                      .order('created_at DESC')
                      .includes(:user, { watering: :mikanz })
    # 未読だったものは既読にする
    @notifications = []
    notifications.each do |n|
      # クライアントに返す情報は、未読のものは未読のままで返したい
      @notifications << Notification.new(n.attributes)
      unless n.read
        n.read = true
        n.save
      end
    end
    @notification_count = 0
    @notifications = Kaminari.paginate_array(@notifications).page(params[:page])
  end
end
