defmodule Rinha.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table("users") do
      add(:limit, :integer, null: false)
      add(:balance, :integer, null: false)
    end
  end
end
