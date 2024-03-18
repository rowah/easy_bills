defmodule EasyBills.Repo.Migrations.CreateUserAddress do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :country, :string
      add :city, :string
      add :street_address, :string
      add :postal_code, :string
      add :phone_number, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
  end
end
