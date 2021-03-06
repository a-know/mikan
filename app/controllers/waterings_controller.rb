# encoding: utf-8

class WateringsController < ApplicationController
  before_action :authenticate

  def new
    raise ActionController::RoutingError, 'ログイン状態で WateringsController#new にアクセスされました'
  end

  def create
    raise ActionController::RoutingError, '自分のミカンを自分で応援することはできません' if self_watering?
    watering = current_user.waterings.build do |w|
      w.mikanz_id = params[:mikanz_id]
    end

    notification = Notification.new(user: owner, watering: watering, kind: 0, read: false)
    success = false

    ActiveRecord::Base.transaction do
      success = watering.save && notification.save
    end

    if success
      flash[:notice] = '応援を完了しました'
      slack_notifier.post("応援登録：#{current_user.nickname} waterings to 「#{Mikanz.find(params[:mikanz_id]).name}」")
      head 201
    else
      render json: { message: watering.errors.full_messages }, status: 422
    end
  end

  def destroy
    watering = current_user.waterings.find_by!(mikanz_id: params[:mikanz_id])
    Notification.find_by(watering_id: watering.id).destroy
    watering.destroy!
    redirect_to mikanz_path(params[:mikanz_id]), notice: 'このミカンへの応援を取り消しました'
  end

  def users_waterings
    @waterings = current_user.waterings.includes(:mikanz).order('created_at DESC').page(params[:page])
  end

  private

  def self_watering?
    mikanz = Mikanz.find(params[:mikanz_id])
    current_user.id == mikanz.owner.id
  end

  def owner
    mikanz = Mikanz.find(params[:mikanz_id])
    mikanz.owner
  end
end
