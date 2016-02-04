require "rack"
require_relative 'middleWAR'

flash_app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  router.run(req, res)
  res.finish
end

app = Rack::Builder.new do
  use ExceptionSaver
  run flash_app
end.to_app
