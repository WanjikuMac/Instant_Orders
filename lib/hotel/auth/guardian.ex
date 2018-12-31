defmodule Hotel.Auth.Guardian do
  @moduledoc """
    Authentication serializer and parse for guardian
  """

  use Guardian, otp_app: :hotel

  alias Hotel.{
      Accounts,
      Accounts.User
    }

    def subject_for_token(%User{} =user, _claims) do
    {:ok, "User:#{user.id}"}
    end

    def subject_for_token(_, _) do
    {:error, :unknown_resource_type}
    end

    def resource_from_claims(%{"sub" => sub}), do: resource_from_subject(sub)
    def resource_from_claims(_), do: {:error, :missing_subject}

    defp resource_from_subject("User:" <> id), do: Accounts.get_user(id)
    defp resource_from_subject(_), do: {:error, :unknown_resource_type}
end