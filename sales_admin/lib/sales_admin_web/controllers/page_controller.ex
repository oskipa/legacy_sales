defmodule SalesAdminWeb.PageController do
  use SalesAdminWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
