defmodule EasyBills.Accounts.UserBusinessAddress do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias EasyBills.Accounts.User

  schema "addresses" do
    field :country, :string
    field :city, :string
    field :street_address, :string
    field :postal_code, :string
    field :phone_number, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:country, :city, :street_address, :postal_code, :phone_number])
    |> validate_required([:country, :city, :street_address, :postal_code, :phone_number])
  end
end
