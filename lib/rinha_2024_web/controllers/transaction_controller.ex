defmodule RinhaWeb.TransactionController do
  use RinhaWeb, :controller

  alias Rinha.Repo
  alias Rinha.Users
  alias Rinha.Users.User
  alias Rinha.Transactions
  alias Rinha.Transactions.Transaction

  action_fallback RinhaWeb.FallbackController

  def handle(conn, params) do
    user = Users.get_user!(params["id"])

    params = %{
      user_id: user.id,
      type: params["tipo"],
      value: params["valor"],
      description: params["descricao"],
    }

    with %Ecto.Changeset{valid?: true} = transaction_changeset <- Transactions.change_transaction(%Transaction{}, params) do
      transaction = Ecto.Changeset.apply_changes(transaction_changeset)

      with %Ecto.Changeset{valid?: true} = user_changeset <- Users.change_user(user, %{balance: new_balance(user, transaction)}) do
        user = Ecto.Changeset.apply_changes(user_changeset)

        with {:ok, _result} <- commit_transaction(user_changeset, transaction_changeset) do
          json(conn, %{
            limite: user.limit,
            saldo: user.balance,
          })
        end
      end
    end
  end

  defp new_balance(%User{balance: user_balance}, %Transaction{} = transaction) do
    user_balance + Transaction.get_value(transaction)
  end

  defp commit_transaction(%Ecto.Changeset{} = user_changeset, %Ecto.Changeset{} = transaction_changeset) do
    Ecto.Multi.new()
    |> Ecto.Multi.update(:update_user, user_changeset)
    |> Ecto.Multi.insert(:insert_transaction, transaction_changeset)
    |> Repo.transaction()
  end
end
