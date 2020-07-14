class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :logout]
  
  def show
    @parents = Category.where(ancestry: nil)
  end

  def logout
  end

end
