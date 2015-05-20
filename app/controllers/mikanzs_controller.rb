# encoding: utf-8

class MikanzsController < ApplicationController
  before_action :authenticate, except: :show
  before_action :set_available_tags_to_gon, only: [:new, :edit, :update]

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

  def edit
    @mikanz = current_user.created_mikanzs.find(params[:id])
  end

  def update
    @mikanz = current_user.created_mikanzs.find(params[:id])
    if @mikanz.update(mikanz_param)
      redirect_to @mikanz, notice: '登録しました'
    else
      render :edit
    end
  end

  def destroy
    @mikanz = current_user.created_mikanzs.find(params[:id])
    @mikanz.destroy!
    redirect_to root_path, notice: '削除しました'
  end

  def show
    @mikanz = Mikanz.find(params[:id])
    @watering  = current_user && current_user.waterings.find_by(mikanz_id: params[:id])
    @waterings = @mikanz.waterings.includes(:user).order(:created_at)
  end

  private

  def mikanz_param
    params.require(:mikanz).permit(:name, :content, :completion, :mikanz_image, :mikanz_image_cache, :remove_mikanz_image, :tag_list)
  end

  def set_available_tags_to_gon
    gon.available_tags = Mikanz.tags_on(:tags).pluck(:name)
  end
end
