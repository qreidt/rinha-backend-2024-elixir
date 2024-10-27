defmodule Rinha.TransactionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rinha.Transactions` context.
  """

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        description: "some description",
        type: "some type",
        value: 42
      })
      |> Rinha.Transactions.create_transaction()

    transaction
  end
end
