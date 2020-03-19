# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale

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
end
