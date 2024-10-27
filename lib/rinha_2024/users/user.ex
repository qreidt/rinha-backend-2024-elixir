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
    |> validate_required([:balance])
    |> validate_limit()
  end

  defp validate_limit(changeset) do
    validate_change(changeset, :balance, fn (:balance, balance) ->
      limit = get_field(changeset, :limit)

      if balance >= -limit, do: [], else: [_: "Operação negada"]
    end)
  end

end
