defmodule RinhaWeb.ExtratoController do
  use RinhaWeb, :controller

  alias Rinha.Users
  # alias Rinha.Users.User

  action_fallback RinhaWeb.FallbackController

  def handle(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    json(conn, %{
      saldo: %{
        total: user.balance,
        limite: user.limit,
        data_extrato: DateTime.utc_now
      },
      ultimas_transacoes: []
    })
  end

  # def create(conn, %{"user" => user_params}) do
  #   with {:ok, %User{} = user} <- Users.create_user(user_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", ~p"/api/users/#{user}")
  #     |> render(:show, user: user)
  #   end
  # end

  # def update(conn, %{"id" => id, "user" => user_params}) do
  #   user = Users.get_user!(id)

  #   with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
  #     render(conn, :show, user: user)
  #   end
  # end
end
