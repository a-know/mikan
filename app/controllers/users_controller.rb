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
    user = User.find_by(nickname: params['user_nickname'])
    notifications = user.notifications.order('created_at ASC')
    # 未読だったものは既読にする
    @notifications = []
    notifications.each do |n|
      @notifications << n
      unless n.read
        n.read = true
        n.save
      end
    end
  end
end
