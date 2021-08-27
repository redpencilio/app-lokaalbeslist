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
  # subscription-service
  ###############################################################
  
  match "/subscription/*path", @json do
    Proxy.forward conn, path, "http://lokaalbeslist-subscription/"
  end

  ###############################################################
  # Resources
  ###############################################################

  get "/agendapunten/*path", @json do
    Proxy.forward conn, path, "http://resource/agendapunten/"
  end

  get "/behandelingen-van-agendapunten/*path", @json do
    Proxy.forward conn, path, "http://resource/behandelingen-van-agendapunten/"
  end

  get "/werkingsgebieden/*path", @json do
    Proxy.forward conn, path, "http://resource/werkingsgebieden/"
  end

  get "/bestuurseenheden/*path", @json do
    Proxy.forward conn, path, "http://resource/bestuurseenheden/"
  end

  get "/bestuursorganen/*path", @json do
    Proxy.forward conn, path, "http://resource/bestuursorganen/"
  end

  get "/zittingen/*path", @json do
    Proxy.forward conn, path, "http://resource/zittingen/"
  end

  get "/mandatarissen/*path", @json do
    Proxy.forward conn, path, "http://resource/mandatarissen/"
  end

  get "/personen/*path", @json do
    Proxy.forward conn, path, "http://resource/personen/"
  end

  get "/besluiten/*path", @json do
    Proxy.forward conn, path, "http://resource/besluiten/"
  end

  get "/stemmingen/*path", @json do
    Proxy.forward conn, path, "http://resource/stemmingen/"
  end

  ###############################################################
  # Frontend (lokaalbeslist)
  ###############################################################

  get "/favicon.ico", @any do
    send_resp( conn, 404, "" )
  end

  get "/*path", %{ last_call: true } do
    Proxy.forward conn, path, "http://lokaalbeslist/"
  end

  #################################################################
  # 404
  #################################################################

  match "/*_", %{ last_call: true } do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
