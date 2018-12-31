defmodule HotelWeb.Resolvers.AccountsTest do
  use HotelWeb.ApiCase

  alias Hotel.{
    Accounts.User
  }

  describe " Accounts Resolver" do
    test "log in a user to the system with a username", %{conn: conn} do
      params = %{username: "WanjikuMac", password: "hash", email: "edwardscaroline32@gmail.com"}
      {:ok, %User{} = user} = %User{} |> User.changeset(params) |> Repo.insert()

      assert Repo.aggregate(User, :count, :id) == 1

      variables = %{
        "input" => %{
          "sign_in_param" => user.username,
          "password" => "hash"
        }
      }

      query = """
        mutation($input: SessionInput!){
          sign_in(input: $input){
            token
            user{
              username
              email
            }
          }
        }
      """

      res = post(conn, "api/graphiql", query: query, variables: variables)

      %{
        "data" => %{

          "sign_in" => result
        }
      } = json_response(res, 200)

      assert result["token"]
      assert result["user"]["username"] == user.username
      assert result["user"]["email"] == user.email
    end
  end
end
