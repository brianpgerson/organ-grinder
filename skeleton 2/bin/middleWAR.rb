require 'rack'
require 'byebug'

class ExceptionSaver
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    @req = Rack::Request.new(env)
    begin
      app.call(env)
    rescue Exception => e
      puts e
      debugger
    end
  end
end
