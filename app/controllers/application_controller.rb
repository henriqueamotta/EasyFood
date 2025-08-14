class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern # Permitir apenas navegadores modernos
  before_action :configure_permitted_parameters, if: :devise_controller? # Permitir parâmetros adicionais para o Devise

  protected

  def configure_permitted_parameters # Permitir parâmetros adicionais para o Devise
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ]) # Permitir o parâmetro :name na inscrição
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ]) # Permitir o parâmetro :name na atualização da conta
  end
end
