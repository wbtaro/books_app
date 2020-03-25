# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
    def set_locale
      if params[:locale]
        I18n.locale = params[:locale]
      else
        extracted_locale = extract_locale_from_accept_language
        I18n.locale = (I18n.available_locales.include? extracted_locale.to_sym) ?
                    extracted_locale : I18n.default_locale
      end
    end

    def default_url_options(options = {})
      { locale: I18n.locale }.merge options
    end

    def extract_locale_from_accept_language
      request.env["HTTP_ACCEPT_LANGUAGE"].scan(/^[a-z]{2}/).first
    end

    # ログインユーザー以外のユーザーによる削除を防ぐ
    def confirm_user(owner_id)
      owner_id == current_user.id
    end

  protected
    def update_resource(resource, params)
      if params[:password].present? && params[:password_confirmation].present?
        resource.update_attributes(params)
      else
        resource.update_without_password(params)
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :postal_code, :address, :description, :avatar])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :postal_code, :address, :description, :avatar])
    end
end
