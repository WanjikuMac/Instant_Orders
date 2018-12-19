defmodule Hotel.AuthenticationTestHelpers do
  @moduledoc """
    This module contains utility functions for adding authentication
    headers to connections for tests
  """

  use Phoenix.ConnTest
  import Hotel.Factory

  @doc """
  when given a connection to authenticate create a user call auth with
  the user and add a token in the request header just as a client would do
  when calling the API
  """
  def authenticate(conn) do
    user = insert(:user)

    conn
    |>authenticate(user)
  end

  @doc """
  when given a connection to authenticate with a user create a jwt token for the user
  and attach it as a request header to the connection
  """
  @spec authenticate(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def authenticate(conn, user) do
    #get the token from the user
    {:ok, token, _} = user |> Hotel.Auth.Guardian.encode_and_sign()

    #add the users token to the request header
    conn
    |>put_req_header("authorization", "Bearer #{token}")
  end
end