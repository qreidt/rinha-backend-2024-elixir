defmodule Rinha.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:limit, :integer, writable: :insert)
    field(:balance, :integer)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:balance])
    |> validate_required([:limit, :balance])
    |> validate_change(:balance, &balance_not_negative/2)
  end

  defp balance_not_negative(:balance, balance) do
    if balance >= 0, do: [], else: [balance: "Balance must be > 0."]
  end
end
