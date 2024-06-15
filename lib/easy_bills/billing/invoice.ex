defmodule EasyBills.Billing.Invoice do
  use Ecto.Schema
  import Ecto.Changeset

  alias EasyBills.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "invoices" do
    field :amount, :string
    field :client, :map
    field :description, :string
    field :due_at, :date
    field :from, :map
    field :status, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(invoice, attrs) do
    invoice
    |> cast(attrs, [:from, :client, :due_at, :amount, :status, :description])
    |> validate_required([:due_at, :amount, :status, :description])
  end
end
