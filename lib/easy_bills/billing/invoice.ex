defmodule EasyBills.Billing.Invoice do
  use Ecto.Schema
  import Ecto.Changeset

  alias EasyBills.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "invoices" do
    field :description, :string
    field :due_at, :date
    field :client_name, :string
    field :client_email, :string
    field :client_street_address, :string
    field :client_city, :string
    field :client_postal_code, :string
    field :client_country, :string
    field :terms, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(invoice, attrs) do
    invoice
    |> cast(attrs, [
      :due_at,
      :description,
      :client_name,
      :client_email,
      :client_street_address,
      :client_city,
      :client_postal_code,
      :client_country,
      :terms
    ])
    |> validate_required([
      :due_at,
      :description,
      :client_name,
      :client_email,
      :client_street_address,
      :client_city,
      :client_postal_code,
      :client_country,
      :terms
    ])
  end
end
