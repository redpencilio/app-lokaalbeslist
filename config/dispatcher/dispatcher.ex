defmodule Dispatcher do
  use Plug.Router

  def start(_argv) do
    port = 80
    IO.puts "Starting Plug with Cowboy on port #{port}"
    Plug.Adapters.Cowboy.http __MODULE__, [], port: port
    :timer.sleep(:infinity)
  end

  plug Plug.Logger
  plug :match
  plug :dispatch

  # In order to forward the 'themes' resource to the
  # resource service, use the following forward rule.
  #
  # docker-compose stop; docker-compose rm; docker-compose up
  # after altering this file.
  #
  # match "/themes/*path" do
  #   Proxy.forward conn, path, "http://resource/themes/"
  # end

  match "/bestuurseenheden/*path" do
    Proxy.forward conn, path, "http://cache/bestuurseenheden/"
  end
  match "/werkingsgebieden/*path" do
    Proxy.forward conn, path, "http://cache/werkingsgebieden/"
  end
  match "/bestuurseenheid-classificatie-codes/*path" do
    Proxy.forward conn, path, "http://cache/bestuurseenheid-classificatie-codes/"
  end
  match "/bestuursorganen/*path" do
    Proxy.forward conn, path, "http://cache/bestuursorganen/"
  end
  match "/bestuursorgaan-classificatie-codes/*path" do
    Proxy.forward conn, path, "http://cache/bestuursorgaan-classificatie-codes/"
  end
  match "/personen/*path" do
    Proxy.forward conn, path, "http://cache/personen/"
  end
  match "/geslacht-codes/*path" do
    Proxy.forward conn, path, "http://cache/geslacht-codes/"
  end

  match "/gebruikers/*path" do
    Proxy.forward conn, path, "http://cache/gebruikers/"
  end

  match "/document-statuses/*path" do
    Proxy.forward conn, path, "http://cache/document-statuses/"
  end
  get "/files/:id/download" do
    Proxy.forward conn, [], "http://file/files/" <> id <> "/download"
  end
  get "/files/*path" do
    Proxy.forward conn, path, "http://resource/files/"
  end

  match "/file-addresses/*path" do
    Proxy.forward conn, path, "http://resource/file-addresses/"
  end

  ###############################################################
  # dynamic-forms-domain.lisp
  ###############################################################
  match "/form-nodes/*path" do
    Proxy.forward conn, path, "http://cache/form-nodes/"
  end
  match "/form-inputs/*path" do
    Proxy.forward conn, path, "http://cache/form-inputs/"
  end
  match "/dynamic-subforms/*path" do
    Proxy.forward conn, path, "http://cache/dynamic-subforms/"
  end
  match "/input-states/*path" do
    Proxy.forward conn, path, "http://cache/input-states/"
  end

  ###############################################################
  # master-toezicht-domain.lisp
  ###############################################################
  match "/inzendingen-voor-toezicht/*path" do
    Proxy.forward conn, path, "http://cache/inzendingen-voor-toezicht/"
  end
  match "/toezicht-tax-types/*path" do
    Proxy.forward conn, path, "http://cache/toezicht-tax-types/"
  end
  match "/toezicht-nomenclatures/*path" do
    Proxy.forward conn, path, "http://cache/toezicht-nomenclatures/"
  end
  match "/toezicht-fiscal-periods/*path" do
    Proxy.forward conn, path, "http://cache/toezicht-fiscal-periods/"
  end
  match "/toezicht-delivery-report-types/*path" do
    Proxy.forward conn, path, "http://cache/toezicht-delivery-report-types/"
  end
  match "/toezicht-account-acceptance-statuses/*path" do
    Proxy.forward conn, path, "http://cache/toezicht-account-acceptance-statuses/"
  end
  match "/toezicht-document-authenticity-types/*path" do
    Proxy.forward conn, path, "http://cache/toezicht-document-authenticity-types/"
  end
  match "/toezicht-regulation-types/*path" do
    Proxy.forward conn, path, "http://cache/toezicht-regulation-types/"
  end
  match "/toezicht-inzending-types/*path" do
    Proxy.forward conn, path, "http://cache/toezicht-inzending-types/"
  end
  match "/besluit-types/*path" do
    Proxy.forward conn, path, "http://cache/besluit-types/"
  end
  match "/tax-rates/*path" do
    Proxy.forward conn, path, "http://cache/tax-rates/"
  end

  match "/simplified-tax-rates/*path" do
    Proxy.forward conn, path, "http://cache/simplified-tax-rates/"
  end

  match "/form-solutions/*path" do
    Proxy.forward conn, path, "http://cache/form-solutions/"
  end

  match "/melding-statuses/*path" do
    Proxy.forward conn, path, "http://cache/melding-statuses/"
  end
  match "/inzending-voor-toezicht-meldingen/*path" do
    Proxy.forward conn, path, "http://cache/inzending-voor-toezicht-meldingen/"
  end

  ###############################################################
  # Searching
  ###############################################################

  # TODO rename to something else
  # match "/submissions/*path" do
  #   Proxy.forward conn, path, "http://search/submissions/"
  # end

  ###############################################################
  # Registration and login
  ###############################################################
  match "/accounts/*path" do
    Proxy.forward conn, path, "http://resource/accounts/"
  end
  match "/gebruikers/*path" do
    Proxy.forward conn, path, "http://resource/gebruikers/"
  end
  match "/permissions/*path" do
    Proxy.forward conn, path, "http://resource/permissions/"
  end
  match "/sessions/*path" do
    Proxy.forward conn, path, "http://login/sessions/"
  end
  match "/mock/sessions/*path" do
    Proxy.forward conn, path, "http://mocklogin/sessions/"
  end

  #################################################################
  # Test Stack Auto Meldingen
  #################################################################

  get "/submissions/*path" do
    Proxy.forward conn, path, "http://resource/submissions/"
  end

  get "/authenticity-types/*path" do
    Proxy.forward conn, path, "http://cache/authenticity-types/"
  end

  get "/tax-types/*path" do
    Proxy.forward conn, path, "http://cache/tax-types/"
  end

  get "/chart-of-accounts/*path" do
    Proxy.forward conn, path, "http://cache/chart-of-accounts/"
  end

  get "/submission-document-statuses/*path" do
    Proxy.forward conn, path, "http://cache/submission-document-statuses/"
  end

  #################################################################
  # manual submission
  #################################################################

  get "/submission-forms/*path" do
    Proxy.forward conn, path, "http://enrich-submission/submission-documents/"
  end

  get "/submission-documents/*path" do
    Proxy.forward conn, path, "http://cache/submission-documents/"
  end

  get "/form-data/*path" do
    Proxy.forward conn, path, "http://resource/form-data/"
  end

  get "/concept-schemes/*path" do
    Proxy.forward conn, path, "http://cache/concept-schemes/"
  end

  get "/concepts/*path" do
    Proxy.forward conn, path, "http://cache/concepts/"
  end

  match _ do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
