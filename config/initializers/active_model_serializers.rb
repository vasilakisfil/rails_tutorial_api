ActiveModelSerializers.config.adapter = :json_api

ActionDispatch::ParamsParser::DEFAULT_PARSERS[Mime::Type.lookup('application/vnd.api+json')]=lambda do |body|
  JSON.parse(body)
end
