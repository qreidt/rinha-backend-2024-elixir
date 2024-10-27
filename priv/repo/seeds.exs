# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rinha.Repo.insert!(%Rinha.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Rinha.Repo.insert!(%Rinha.Users.User{limit:    100_000, balance: 0})
Rinha.Repo.insert!(%Rinha.Users.User{limit:     80_000, balance: 0})
Rinha.Repo.insert!(%Rinha.Users.User{limit:  1_000_000, balance: 0})
Rinha.Repo.insert!(%Rinha.Users.User{limit: 10_000_000, balance: 0})
Rinha.Repo.insert!(%Rinha.Users.User{limit:    500_000, balance: 0})
