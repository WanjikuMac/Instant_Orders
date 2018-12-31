defmodule HotelWeb.ApiCase do
  @moduledoc """
  This module holds the test case to be used by tests
  that require setting up a connection working on the GraphQL
  API endpoints

  Such tests rely on `Phoenix.ConnTest` and also import other functionality to
  make it easier to build common data structures and query the data layer

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs inside
  a transaction which is reset at the beginning of the test unless
  the test case is marked as async.
  """

  use ExUnit.CaseTemplate
  import Hotel.Factory
  use Phoenix.ConnTest

  using do
    quote do
      #import conveniences for testing with connections
      use Phoenix.ConnTest
      import HotelWeb.Router.Helpers
      alias Hotel.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Hotel.Factory

      #The default endpoint for testing
      @endpoint HotelWeb.Endpoint
    end
  end

  setup context do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Hotel.Repo)

    unless context[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Hotel.Repo, {:shared, self()})
    end

    {conn, user} =
    #credo:disable-for-next-line

    cond do
      context[:authenticated] ->
        build_conn()
          |> add_authentication_headers(context[:authenticated])

        true ->
          conn = build_conn()
          {conn, nil}
        end

    {:ok, conn: conn, current_user: user}
  end

  #add information to connection
  @spec add_authentication_headers(Plug.Conn.t(), String.t()) :: {Plug.Conn.t(), any()}
  defp add_authentication_headers(conn, _any) do
    user = insert(:user)

    conn = conn |> Hotel.AuthenticationTestHelpers.authenticate(user)

    {conn, user}
  end
end