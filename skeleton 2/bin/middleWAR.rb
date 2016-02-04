require 'rack'
require 'byebug'

class ExceptionSaver
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    @req = Rack::Request.new(env)
    @res = Rack::Response.new
    begin
      app.call(env)
    rescue Exception => e
      source_code_path = source_code_finder(e)
      html_writer(e, source_code_path)
      lines = File.readlines("error_html.html.erb").map {|l|l.chomp}.join

      @res.write(lines)
      File.delete("error_html.html.erb")
      @res['Content-Type'] = 'text/html'
      @res.finish
    end
  end


  def stack_trace_handler(exception)
    html = File.open("error_html.html.erb", "a")

    html.write("<h1>Oh no! You done fucked up, kid.</h1><p>Exception: #{exception.message}</p>")
    html.write("<p>Stack Trace:</p><")

    exception.backtrace.each do |line|
      html.write("#{line}<br>\n")
    end
    html.close
  end

  def html_writer(exception, source_code_path)
    stack_trace_handler(exception)
    chunk_handler(source_code_path)
  end

  def chunk_handler(source_code_path)
    source_code = File.readlines(source_code_path[0])
    path = source_code_path[1]
    chunk = source_code[path - 4..path + 4].reject{ |line| line == "\n" }.map { |l| l.chomp }

    html = File.open("error_html.html.erb", "a")
    html.write("<p>Source Code:</p>")
      chunk.each do |line|
      html.write("#{line}<br>\n")
    end
    html.close
  end

  def source_code_finder(exception)
    line = exception.backtrace.first
    path = Regexp.new(/[^:]*/).match(line)[0]
    line_number = Regexp.new(/(?<=rb:)\d+/).match(line)[0].to_i
    [path, line_number]
  end



end
