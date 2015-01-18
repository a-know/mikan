# encoding: utf-8

class MikanzsController < ApplicationController
  before_action :authenticate, except: :show

  def new
    @mikanz = current_user.created_mikanzs.build
  end

  def create
    @mikanz = current_user.created_mikanzs.build(mikanz_param)
    if @mikanz.save
      redirect_to @mikanz, notice: '登録しました'
    else
      render :new
    end
  end

  def show
    @mikanz = Mikanz.find(params[:id])
  end

  private

  def mikanz_param
    params.require(:mikanz).permit(:name, :content, :start_time)
  end
end
