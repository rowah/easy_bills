defmodule EasyBills.Repo.Migrations.AddUserDetails do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :address, :map
      add :avatar_url, :string
      add :name, :string
      add :username, :string
    end
  end
end
