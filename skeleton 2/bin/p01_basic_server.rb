require 'rack'

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new

  fun_message = req.path
  fun_query = req.query_string

  res['Content-Type'] = 'text/html'
  res.write("#{fun_query}")

  res.finish
end

Rack::Server.start(
  app: app,
  Port: 3000
)
