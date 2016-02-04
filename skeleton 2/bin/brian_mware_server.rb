require 'rack'
require_relative '../lib/controller_base'
require_relative '../lib/router'
require_relative 'middleWAR'
require_relative 'fun_image'

class MakeFlash < ControllerBase
  def index
      render_content(dogs, "application/json")
  end

  def set_flash_then_redirect
    flash['cool'] = "dogs!"
    redirect_to('/flash')
  end

  def set_flash_then_render
    flash['cool'] = "dogs!"
    render_content(flash['cool'].to_json, "application/json")
  end

end

router = Router.new
router.draw do
  get Regexp.new("^/flash$"), MakeFlash, :index
  get Regexp.new("^/redir$"), MakeFlash, :set_flash_then_redirect
  get Regexp.new("^/render$"), MakeFlash, :set_flash_then_render
end

flash_app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  router.run(req, res)
  res.finish
end

app = Rack::Builder.new do
  use ExceptionSaver
  use FunImage
  run flash_app
end.to_app


Rack::Server.start(
 app: app,
 Port: 3000
)
