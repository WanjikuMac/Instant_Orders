defmodule HotelWeb.Schema.AccountTypes do
  @moduledoc """
  This module contains GraphQl types used with the accounts context
  """
  use Absinthe.Schema.Notation

  alias HotelWeb.Resolvers.Accounts

  @desc "contains queries used in the accounts context "
  object :account_queries do
    @desc "Query for the list of available users"
    field :users, list_of (:user) do
      resolve(&Accounts.get_users/3)
    end
  end

  @desc "Contains mutations used in the account context"
    object :account_mutations do
  @desc "A mutation to support user sign up"
    field :sign_up, :user do
     arg(:input, non_null(:sign_up_input))
     resolve(&Accounts.sign_up/3)
  end

  @desc "A mutation to support building a session once a user signs in"
  field :sign_in, :user do
    arg(:input, non_null(:session_input))
    resolve(&Accounts.sign_in/3)
  end
 end

  @desc "User object"
    object :user do
      field(:id, :id)
      field(:username, :string)
      field(:email, :string)
  end

  @desc "Contains input object for a user sign up"
  input_object :sign_up_input do
    field(:username, non_null(:string))
    field(:email, non_null(:string))
    field(:password, non_null(:string))
  end

  @desc "a session object on the system"
  object :session do
    field(:user, :user)
    field(:token, :string)
  end

  @desc "input object for a session"
  input_object :session_input do
    field(:sign_in_params, non_null(:string))
    field(:password, non_null(:string))
  end
end