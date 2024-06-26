defmodule EasyBills.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EasyBills.Accounts` context.
  """

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "NewvalidPassword!1@"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_user_email(),
      name: "John",
      password: valid_user_password(),
      policy_and_terms: true,
      username: "Doe"
    })
  end

  def user_address do
    %{
      city: "Nairobi",
      country: "Kenya",
      postal_code: "00100",
      phone_number: "0726351575",
      street_address: "24136"
    }
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> EasyBills.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end
end
