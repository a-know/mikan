class TopController < ApplicationController
  def index
    @mikanzs = Mikanz.order(:created_at).reverse_order.limit(3)
  end
end
