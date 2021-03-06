class Crinja::Server::SourceHandler
  include TemplateHandler

  def call(context)
    path = context.request.path

    return call_next(context) unless path[0..7] == "/source/"

    path = path[7..-1]

    template = load_template(path)

    context.response.content_type = "text/html"
    render_source(context.response, template)
  rescue e : Crinja::TemplateNotFoundError
    @logger.warn e.message
    context.response.respond_with_error "File Not Found", 404
  end

  def render_source(io, template)
    io << %(<link href="/source.css" rel="stylesheet">)
    io << %(<div class="crinja-server-notice">Crinja template code for <code>\
              <a href="#{template.name}">#{template.name}</a></code>:</div>)
    io << "<pre>"
    Crinja::Visitor::HTML.new(io).visit(template)
    io << "</pre>"
  end
end
