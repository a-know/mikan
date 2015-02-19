# encoding: utf-8

class WateringsController < ApplicationController
  before_action :authenticate

  def new
    raise ActionController::RoutingError, 'ログイン状態で WateringsController#new にアクセスされました'
  end
end
