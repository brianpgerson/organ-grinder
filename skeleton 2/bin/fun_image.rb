require 'rack'
require 'byebug'


class FunImage
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    @req = Rack::Request.new(env)
    @res = Rack::Response.new

    if @req.path.match(/^\/public/)
      final_res = serve_that_shit(@req, @res)
      final_res.finish
    else
      app.call(env)
    end
  end


  private

  def serve_that_shit(req, res)

    file = File.read(req.path[1..-1])
    type = Regexp.new(/\.\w+/).match(req.path)[0][1..-1]

    res.body = [file]
    res['Content-Type'] = "image/#{type}"
    res
  end

end
