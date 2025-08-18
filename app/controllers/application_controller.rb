class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern # Permitir apenas navegadores modernos
  before_action :set_locale # Definir o locale antes de cada ação
  before_action :configure_permitted_parameters, if: :devise_controller? # Permitir parâmetros adicionais para o Devise

  private

  def set_locale # Definir o locale com base nos parâmetros, sessão ou padrão
    locale = params[:locale] || session[:locale] || I18n.default_locale # Definir o locale

    if params[:locale].present? && I18n.available_locales.map(&:to_s).include?(params[:locale]) # Verificar se o locale é válido
      session[:locale] = params[:locale] # Armazenar o locale na sessão
    end

    I18n.locale = session[:locale] || I18n.default_locale # Definir o locale
  end

  protected

  def configure_permitted_parameters # Permitir parâmetros adicionais para o Devise
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ]) # Permitir o parâmetro :name na inscrição
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ]) # Permitir o parâmetro :name na atualização da conta
  end
end
