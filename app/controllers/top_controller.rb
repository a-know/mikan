class TopController < ApplicationController
  def index
    @mikanzs = Mikanz.order(:created_at).limit(3)
  end
end
