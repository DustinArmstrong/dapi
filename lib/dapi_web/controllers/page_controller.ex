defmodule DapiWeb.PageController do
  use DapiWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
