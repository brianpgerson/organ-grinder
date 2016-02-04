require 'rack'
require_relative '../lib/controller_base'
require 'json'
require_relative '../lib/router'


class MyController < ControllerBase

  def index
    render ('show')
  end

  def create
    render_content("if you see me I have failed", "text/html")
  end
  
  def new
    render('new')
  end
end

router = Router.new
router.draw do
  get Regexp.new("^/dog/new$"), MyController, :new
  post Regexp.new("^/dogs$"), MyController, :create
end

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  router.run(req, res)
  res.finish
end

Rack::Server.start(
 app: app,
 Port: 3000
)
