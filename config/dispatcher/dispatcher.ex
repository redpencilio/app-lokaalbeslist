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
  get "/files/:id/download" do
    Proxy.forward conn, [], "http://file/files/" <> id <> "/download"
  end
  get "/files/*path" do
    Proxy.forward conn, path, "http://resource/files/"
  end

  ###############################################################
  # Searching
  ###############################################################

  match "/search/*path" do
    Proxy.forward conn, path, "http://search/"
  end

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

  get "/remote-urls/*path" do
    Proxy.forward conn, path, "http://resource/remote-urls/"
  end

  match "/inzendingen-voor-toezicht/*path" do
    Proxy.forward conn, path, "http://cache/inzendingen-voor-toezicht/"
  end

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
  # Manual submission
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

  #################################################################
  # Review
  #################################################################

  get "/submission-review-statuses/*path" do
    Proxy.forward conn, path, "http://cache/submission-review-statuses/"
  end

  match "/submission-reviews/*path" do
    Proxy.forward conn, path, "http://resource/submission-reviews/"
  end

  match _ do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
