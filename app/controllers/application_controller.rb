class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    I18n.locale = current_user.locale if current_user
  end

  def default_url_options
    { locale: I18n.locale }
  end

  protect_from_forgery with: :exception
  include LoginHelper
end