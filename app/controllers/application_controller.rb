class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :last_name, :first_name,:last_name_kana,:first_name_kana,:birthday])
  end
  
  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:basic_auth][:user] &&
      password == Rails.application.credentials[:basic_auth][:pass]
    end
  end
  
  def production?
    Rails.env.production?
  end

  def set_item_search_query
    @search = Item.ransack(params[:q])
    @search_items = @search.result(distinct: true)
  end


end
