defmodule HotelWeb.Schema.Middleware.Authorize do
  @moduledoc """
    This module contains middleware that runs before any resolvers
    that need authentication
  """
  @behaviour Absinthe.Middleware

  @doc """
    This function adds a user connected to the currently signed in token to
    the execution context. If a token is missing or a user tries an action that
    is unauthorized they will get a reply with an authorization error.
  """

  @spec call(map(), list()) :: map()
  def call(resolution, _any) do
    with %{current_user: current_user} <- resolution.context do
      resolution
    else
    _ ->
      resolution
        |> Absinthe.Resolution.put_result({:error, "You are not authorized to perform this operation"})
     end
   end
end