defmodule Dispatcher do
  use Matcher

  define_accept_types [
    json: [ "application/json", "application/vnd.api+json" ],
    any: ["*/*"]
  ]

  @json %{ accept: %{ json: true } }

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
  get "/files/:id/download", @json do
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

  match "/*_", %{ last_call: true } do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
