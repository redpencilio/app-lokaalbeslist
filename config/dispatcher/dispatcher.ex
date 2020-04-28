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

  get "/bestuurseenheden/*path" do
    Proxy.forward conn, path, "http://cache/bestuurseenheden/"
  end
  get "/werkingsgebieden/*path" do
    Proxy.forward conn, path, "http://cache/werkingsgebieden/"
  end
  get "/bestuurseenheid-classificatie-codes/*path" do
    Proxy.forward conn, path, "http://cache/bestuurseenheid-classificatie-codes/"
  end
  get "/bestuursorganen/*path" do
    Proxy.forward conn, path, "http://cache/bestuursorganen/"
  end
  get "/bestuursorgaan-classificatie-codes/*path" do
    Proxy.forward conn, path, "http://cache/bestuursorgaan-classificatie-codes/"
  end
  get "/personen/*path" do
    Proxy.forward conn, path, "http://cache/personen/"
  end
  get "/gebruikers/*path" do
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

  get "/search/*path" do
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
  match "/sessions/*path" do
    Proxy.forward conn, path, "http://login/sessions/"
  end
  match "/mock/sessions/*path" do
    Proxy.forward conn, path, "http://mocklogin/sessions/"
  end

  #################################################################
  # Submissions
  #################################################################

  get "/remote-urls/*path" do
    Proxy.forward conn, path, "http://cache/remote-urls/"
  end

  get "/inzendingen-voor-toezicht/*path" do
    Proxy.forward conn, path, "http://cache/inzendingen-voor-toezicht/"
  end

  get "/submissions/*path" do
    Proxy.forward conn, path, "http://cache/submissions/"
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

  get "/submission-forms/*path" do
    Proxy.forward conn, path, "http://enrich-submission/submission-documents/"
  end

  get "/submission-documents/*path" do
    Proxy.forward conn, path, "http://cache/submission-documents/"
  end

  get "/form-data/*path" do
    Proxy.forward conn, path, "http://cache/form-data/"
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
    Proxy.forward conn, path, "http://cache/submission-reviews/"
  end

  match _ do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
