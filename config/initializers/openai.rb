OpenAI.configure do |config|
  config.acess_token = ENV.fetch("OPENAI_API_KEY")
end
