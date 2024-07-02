defmodule EasyBills.Repo.Migrations.CreateUserAddressTable do
  use Ecto.Migration

  def up do
    alter table(:users) do
      remove :address, :map
    end

    create table(:business_address, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :city, :string
      add :country, :string
      add :street_address, :string
      add :postal_code, :string
      add :phone_number, :string
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all)

      timestamps()
    end

    create index(:business_address, [:user_id])
  end

  def down do
    drop table(:business_address)

    alter table(:users) do
      add :address, :map
    end
  end
end
