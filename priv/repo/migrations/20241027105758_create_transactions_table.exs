defmodule Rinha.Repo.Migrations.CreateTransactionsTable do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :value, :integer, null: false
      add :type, :char, null: false
      add :description, :string, length: 10, null: false

      add(:inserted_at, :utc_datetime)
    end

    create index(:transactions, [:user_id])
  end
end
