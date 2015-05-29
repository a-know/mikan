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
      flash[:notice] = '水やり（応援）を完了しました'
      head 201
    else
      render json: { message: watering.errors.full_messages }, status: 422
    end
  end

  def destroy
    watering = current_user.waterings.find_by!(mikanz_id: params[:mikanz_id])
    Notification.find_by(watering_id: watering.id).each(&:destroy)
    watering.destroy!
    redirect_to mikanz_path(params[:mikanz_id]), notice: 'このミカンへの水やり（応援）を取り消しました'
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
