require 'active_support'
require 'active_support/inflector'
require 'active_support/core_ext'
require 'erb'
require_relative './session'
require_relative './flash'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res, route_params = {})
    @req = req
    @res = res
    @params = route_params.merge(req.params)
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    raise "Can't redirect twice in one call!" if already_built_response?
    @res.status = 302
    @res['Location'] = url
    session.store_session(@res)
    flash.store_flash(@res)
    @already_built_response = true
  end


  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
      raise "Can't render twice in one call!" if already_built_response?
      @res.write(content)
      @res['Content-Type'] = content_type
      session.store_session(@res)
      flash.store_flash(@res)
      @already_built_response = true
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    file_location = "views/#{self.class.to_s.underscore}/#{template_name.to_s.underscore}.html.erb"

    form_authenticity_token = generate_authenticity_token

    content = ERB.new(File.read(file_location)).result(binding)
    render_content(content, 'text/html')
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(@req)
  end

  def flash
    @flash ||= Flash.new(@req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)

    danger_requests = %w[POST PUT PATCH DELETE]
    if danger_requests.include?(@req.request_method)
      unless ensure_authenticity
        raise "YOU ARE NOT WHO YOU SAY YOU ARE"
      end
    end

    self.send(name)
    render(name) unless already_built_response?
  end

  private

  def generate_authenticity_token
    token = SecureRandom::urlsafe_base64
    session['authenticity_token'] = token
    token
  end

  def ensure_authenticity
    debugger
    session['authenticity_token'] == @params["authenticity_token"]
  end
end
