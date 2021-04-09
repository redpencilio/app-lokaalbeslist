defmodule Dispatcher do
  use Matcher

  define_accept_types [
    json: [ "application/json", "application/vnd.api+json" ],
    turtle: ["text/turtle", "application/n-triples"],
    html: [ "text/html", "application/xhtml+html" ],
    any: ["*/*"]
  ]

  @json %{ accept: %{ json: true } }
  @turtle %{ accept: %{ turtle: true } }
  @any %{ accept: %{ any: true } }
  @html %{ accept: %{ html: true } }

  ###############################################################
  # Searching
  ###############################################################

  get "/search/*path", @json do
    Proxy.forward conn, path, "http://search/"
  end

  ###############################################################
  # Frontend (toezicht-abb)
  ###############################################################
  get "/favicon.ico", @any do
    send_resp( conn, 404, "" )
  end

  #################################################################
  # 404
  #################################################################

  match "/*_", %{ last_call: true } do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
