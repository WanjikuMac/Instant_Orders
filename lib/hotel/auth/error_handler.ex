defmodule Hotel.Auth.ErrorHandler do
  @moduledoc """
    This module handles whatever errors occur as we through Guardian pipelines
  """
  import Plug.Conn

  @doc """
    Add an error response to the connection struct
  """
  @spec auth_error(Plug.Conn.t(), tuple(), any()) :: Plug.Conn.t()
    def auth_error(conn, {type, _reason}, _opts) do
      body = to_string(type)

      conn
      |> put_resp_content_type("text/plain")
      |> send_resp(401, body)
  end
end