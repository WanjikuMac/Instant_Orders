defmodule HotelWeb.PageController do
  use HotelWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
