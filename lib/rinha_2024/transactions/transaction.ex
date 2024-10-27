defmodule Rinha.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @types ["c", "d"]

  schema "transactions" do
    field :user_id, :id
    field :value, :integer
    field :type, :string
    field :description, :string

    timestamps(type: :utc_datetime, updated_at: false)
  end

  @doc false
  def changeset(transaction, attrs) do

    transaction
    |> cast(attrs, [:user_id, :value, :type, :description])
    |> validate_required([:value, :type, :description])
    |> validate_length(:description, min: 1, max: 10)
    |> validate_change(:type, &validate_type/2)
  end

  defp validate_type(:type, value) do
    if value in @types, do: [], else: [type: "Operação Inválida"]
  end

  def get_value(%Rinha.Transactions.Transaction{} = transaction) when transaction.type == "c", do: transaction.value
  def get_value(%Rinha.Transactions.Transaction{} = transaction) when transaction.type == "d", do: -transaction.value
  def get_value(%Rinha.Transactions.Transaction{} = _transaction), do: 0
end
