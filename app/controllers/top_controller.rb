class TopController < ApplicationController
  def index
    @mikanzs = Mikanz.order(:created_at).reverse_order.limit(3)
    @tags = Mikanz.tag_counts_on(:tags).order('count DESC, name ASC').sort
  end
end
