class UsersController < ApplicationController
  
  def show
    @parents = Category.where(ancestry: nil)
  end

  def logout
    @parents = Category.where(ancestry: nil)
  end

  def cards
    @parents = Category.where(ancestry: nil)
  end
  
end
