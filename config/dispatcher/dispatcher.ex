defmodule Dispatcher do
  use Matcher

  define_accept_types [
    json: [ "application/json", "application/vnd.api+json" ],
    html: [ "text/html", "application/xhtml+html" ],
    any: ["*/*"]
  ]

  @json %{ accept: %{ json: true } }
  @any %{ accept: %{ any: true } }
  @html %{ accept: %{ html: true } }

  ###############################################################
  # General/Shared
  ###############################################################

  get "/bestuurseenheden/*path", @json do
    Proxy.forward conn, path, "http://cache/bestuurseenheden/"
  end
  get "/werkingsgebieden/*path", @json do
    Proxy.forward conn, path, "http://cache/werkingsgebieden/"
  end
  get "/bestuurseenheid-classificatie-codes/*path", @json do
    Proxy.forward conn, path, "http://cache/bestuurseenheid-classificatie-codes/"
  end
  get "/bestuursorganen/*path", @json do
    Proxy.forward conn, path, "http://cache/bestuursorganen/"
  end
  get "/bestuursorgaan-classificatie-codes/*path", @json do
    Proxy.forward conn, path, "http://cache/bestuursorgaan-classificatie-codes/"
  end
  get "/personen/*path", @json do
    Proxy.forward conn, path, "http://cache/personen/"
  end
  get "/gebruikers/*path", @json do
    Proxy.forward conn, path, "http://cache/gebruikers/"
  end
  get "/files/:id/download", @any do
    Proxy.forward conn, [], "http://file/files/" <> id <> "/download"
  end
  get "/files/*path", @json do
    Proxy.forward conn, path, "http://resource/files/"
  end

  ###############################################################
  # Searching
  ###############################################################

  get "/search/*path", @json do
    Proxy.forward conn, path, "http://search/"
  end

  ###############################################################
  # Registration and login
  ###############################################################

  match "/accounts/*path", @json do
    Proxy.forward conn, path, "http://resource/accounts/"
  end
  match "/gebruikers/*path", @json do
    Proxy.forward conn, path, "http://resource/gebruikers/"
  end
  match "/sessions/*path", @json do
    Proxy.forward conn, path, "http://login/sessions/"
  end
  match "/mock/sessions/*path", @json do
    Proxy.forward conn, path, "http://mocklogin/sessions/"
  end

  #################################################################
  # Submissions
  #################################################################

  get "/remote-urls/*path", @json do
    Proxy.forward conn, path, "http://cache/remote-urls/"
  end

  get "/inzendingen-voor-toezicht/*path", @json do
    Proxy.forward conn, path, "http://cache/inzendingen-voor-toezicht/"
  end

  get "/submissions/*path", @json do
    Proxy.forward conn, path, "http://cache/submissions/"
  end

  get "/authenticity-types/*path", @json do
    Proxy.forward conn, path, "http://cache/authenticity-types/"
  end

  get "/tax-types/*path", @json do
    Proxy.forward conn, path, "http://cache/tax-types/"
  end

  get "/chart-of-accounts/*path", @json do
    Proxy.forward conn, path, "http://cache/chart-of-accounts/"
  end

  get "/submission-document-statuses/*path", @json do
    Proxy.forward conn, path, "http://cache/submission-document-statuses/"
  end

  get "/submission-forms/*path", @json do
    Proxy.forward conn, path, "http://enrich-submission/submission-documents/"
  end

  get "/submission-documents/*path", @json do
    Proxy.forward conn, path, "http://cache/submission-documents/"
  end

  get "/form-data/*path", @json do
    Proxy.forward conn, path, "http://cache/form-data/"
  end

  get "/concept-schemes/*path", @json do
    Proxy.forward conn, path, "http://cache/concept-schemes/"
  end

  get "/concepts/*path", @json do
    Proxy.forward conn, path, "http://cache/concepts/"
  end

  #################################################################
  # Review
  #################################################################

  get "/submission-review-statuses/*path", @json do
    Proxy.forward conn, path, "http://cache/submission-review-statuses/"
  end

  match "/submission-reviews/*path", @json do
    Proxy.forward conn, path, "http://cache/submission-reviews/"
  end

  ###############################################################
  # Frontend (toezicht-abb)
  ###############################################################
  get "/favicon.ico", @any do
    send_resp( conn, 404, "" )
  end

  get "/assets/*path", @any do
    forward conn, path, "http://toezicht-abb/assets/"
  end

  get "/@appuniversum/*path", @any do
    forward conn, path, "http://toezicht-abb/@appuniversum/"
  end

  match "/authorization/callback" , @html do
    # For ACM/IDM login and torii
    forward conn, [], "http://toezicht-abb/torii/redirect.html"
  end

  match "/*_path", @html do
    # *_path allows a path to be supplied, but will not yield
    # an error that we don't use the path variable.
    forward conn, [], "http://toezicht-abb/index.html"
  end

  #################################################################
  # 404
  #################################################################

  match "/*_", %{ last_call: true } do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
