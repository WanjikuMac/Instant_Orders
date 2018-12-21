defmodule HotelWeb.Schema do
  @moduledoc """
  This module holds the GraphQl Schema for the Hotel platform
  """
  use Absinthe.Schema

  alias HotelWeb.{
      Schema.Middleware
    }

  #import types
  import_types Absinthe.Type.Custom
  import_types(__MODULE__.AccountTypes)

  #Apply middleware to field depending on meta keys
  @doc """
  The middleware/3 takes middleware and field identifier that aid in connection
  to the api database
  """
  @spec middleware(Middleware.t(), any(), any()) :: Middleware.t()
  def middleware(middleware, %{identifier: _fid} = field, %{identifier: old}) do
    middleware =
      case old do
        :mutation ->
          middleware ++ [Middleware.ChangesetErrors]

        _ -> middleware
      end

      meta = Absinthe.Type.meta(field, :auth)

      case meta do
        nil ->
          middleware
        meta ->
        [{{Middleware.Authorize, :call}, meta} | middleware]
    end
  end

  @doc """
  This function takes a middleware struct and implements the middleware function
  above
  """
  @spec middleware(Middleware.t(), any(), any()) :: Middleware.t()
  def middleware(middleware, _, _) do
    middleware
  end

  query do
    import_fields(:account_queries)
  end

  mutation do
    import_fields(:account_mutations)
  end
end