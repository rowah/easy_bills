defmodule EasyBills.Accounts.BusinessAddress do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "business_address" do
    field :city, :string
    field :country, :string
    field :street_address, :string
    field :postal_code, :string
    field :phone_number, :string
    belongs_to :user, EasyBills.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(business_address, attrs) do
    business_address
    |> cast(attrs, [:city, :country, :street_address, :postal_code, :phone_number])
    |> validate_required([:city, :country, :street_address, :postal_code, :phone_number])
  end
end
