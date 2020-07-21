class CategoriesController < ApplicationController
  before_action :set_category, only: :show
  before_action :set_item_search_query
  before_action :set_parent

  def index
  end

end
