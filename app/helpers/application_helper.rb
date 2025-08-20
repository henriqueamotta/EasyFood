module ApplicationHelper
  def language_selector_flag
    # Verifica o idioma (locale) atual da aplicação
    case I18n.locale
    when :'pt-BR'
      # Se for pt-BR, retorna as classes CSS para a bandeira do Brasil
      "fi fi-br"
    when :en
      # Se for en, retorna as classes para a bandeira dos EUA
      "fi fi-us"
    when :es
      # Se for es, retorna as classes para a bandeira da Espanha
      "fi fi-es"
    else
      # Como um fallback seguro, retorna as classes para o ícone de globo
      "bi bi-globe"
    end
  end
end
