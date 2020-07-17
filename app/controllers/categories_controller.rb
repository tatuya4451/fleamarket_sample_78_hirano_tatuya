class CategoriesController < ApplicationController
  before_action :set_category, only: :show
  before_action :set_item_search_query

  def index
    @parents = Category.where(ancestry: nil)
  end

  def show
    @items = @category.set_items
    @items = @items.where(buyer_id: nil).order("created_at DESC").page(params[:page]).per(9)
  end

  private
  def set_category
    @category = Category.find(params[:id])
  end

end
