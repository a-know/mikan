# encoding: utf-8

class WateringsController < ApplicationController
  before_action :authenticate

  def new
    raise ActionController::RoutingError, 'ログイン状態で WateringsController#new にアクセスされました'
  end

  def create
    watering = current_user.waterings.build do |w|
      w.mikanz_id = params[:mikanz_id]
    end
    if watering.save
      flash[:notice] = '水やり（応援）を完了しました'
      head 201
    else
      render json: { message: watering.errors.full_messages }, status: 422
    end
  end
end
