defmodule Hotel.Auth.BearerAuth do
  @moduledoc """
    Authentication pipelines used by Guardian
  """

  use Guardian.Plug.Pipeline,
    otp_app: :hotel,
    error_handler: Hotel.Auth.ErrorHandler,
    module: Hotel.Auth.Guardian

  #if there is a session token, validate it
  plug(Guardian.Plug.VerifySession, claims: %{"typ" => "access"})
  #if there is an authorization header, validate it
  plug(Guardian.Plug.VerifyHeader, realm: "Bearer")

  #load the user if either of the verifications worked allow_blank so that Guardian doesn't
  #throw an error when no user
  plug(Guardian.Plug.LoadResource, allow_blank: true)
end