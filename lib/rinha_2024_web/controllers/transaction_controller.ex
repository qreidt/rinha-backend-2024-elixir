defmodule RinhaWeb.TransactionController do
  use RinhaWeb, :controller

  alias Rinha.Users
  alias Rinha.Transactions
  alias Rinha.Transactions.Transaction

  action_fallback RinhaWeb.FallbackController

  def handle(conn, params) do
    user = Users.get_user!(params["id"])
    IO.inspect(params)
    params = %{
      user_id: user.id,
      type: params["tipo"],
      value: params["valor"],
      description: params["descricao"],
    }

    with {:ok, %Transaction{} = transaction} <- Transactions.create_transaction(params) do
      conn
      |> put_status(:created)
      |> json(%{
        valor: transaction.value,
        tipo: transaction.type,
        descricao: transaction.description
      })
    end
  end
end
