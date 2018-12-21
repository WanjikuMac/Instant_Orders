defmodule HotelWeb.Context do
  @moduledoc """
   This module is a plug that we use to populate the execution context for requests
  """
  @behaviour Plug
  import Plug.Conn


  def init(opts), do: opts
  @doc """
  The call/2 is plug function that takes in a connection struct and checks if it contains
  a token. If present it fetches the associated resource and appends it to the context
  """
  @spec call(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def call(conn, _) do
    current_context = build_context(conn)

    Absinthe.Plug.put_options(conn, context: current_context)
  end

  @spec build_context(Plug.Conn.t()) :: map()
  defp build_context(conn) do
    with ["Bearer" <> token] <- get_req_header(conn, "authorization"),
         {:ok, user, _} = Hotel.Auth.Guardian.resource_from_token(token) do
      %{current_user: user}
    else
     _ -> %{}
    end
  end
end