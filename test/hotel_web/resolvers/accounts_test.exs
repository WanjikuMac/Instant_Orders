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

    test "logs user on to the system with an email", %{conn: conn} do
      {:ok, user} =
        %User{}
        |> User.changeset(%{
          username: "WanjikuMac",
          password: "hash",
          email: "edwardscaroline32@gmail.com"
        })
        |> Repo.insert()

      assert Repo.aggregate(User, :count, :id) == 1

      variables = %{
        "input" => %{
          "sign_in_param" => user.email,
          "password" => "hash"
        }
      }

      query = """
        mutation($input: SessionInput!){
          signIn(input: $input){
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
          "signIn" => result
        }
      } = json_response(res, 200)

      assert result["token"]
      assert result["user"]["username"] == user.username
      assert result["user"]["email"] == user.email
    end

    test "fetches users on the system", %{conn: conn} do
      insert_list(4, :user)
      assert Repo.aggregate(User, :count, :id) == 4

    query = """
      query{
        Users{
          username
          id
          }
        }
      """

      res = post(conn, "api/graphiql", query: query)

      %{
        "data" => %{
          "Users" => users
        }
      } = json_response(res, 200)

      assert Enum.count(users) == 4
    end

    test "signs up a user", %{conn: conn} do
      assert Repo.aggregate(User, :count, :id) == 0

      variables = %{
        "input" => %{
          "username" => "WanjikuMac",
          "email" => "edwardscaroline32@gmail.com",
          "password" => "hash"
        }
      }

      query = """
        mutation($input: SignUpInput!){
          signUp(input: $input){
            username
              email
          }
        }
      """

      res = post(conn, "api/graphiql", query: query, variables: variables)

      %{
        "data" => %{
          "signUp" => new_user
        }
      } = json_response(res, 200)

      assert Repo.aggregate(User, :count, :id) == 1
      assert new_user["username"] == variables["input"]["username"]
    end

    test "returns an error when no users are in the database", %{conn: conn} do
      assert Repo.aggregate(User, :count, :id) == 0

      query = """
      {
        Users {
          username
          id
        }
      }
      """

      res = post(conn, "api/graphiql", query: query)

      %{
        "errors" => [_result|_]
      } =json_response(res, 200)
    end
  @tag :signup
    test "Sign in returns an error if user is not found in the database", %{conn: conn} do

      assert Repo.aggregate(User, :count, :id) == 0

      variables = %{
        "input" => %{
          "sign_in_param" => "username_or_email",
          "password" => "hash"
        }
      }

      query = """
        mutation($input: SessionInput!){
          signIn(input: $input){
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
        "errors" => [result | _]
      } = json_response(res, 200)

      assert "Access Denied" <> _rest = result["message"]
    end
  end
end
