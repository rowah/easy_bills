defmodule EasyBills.Accounts.UserNotifier do
  @moduledoc false

  alias EasyBills.Emails

  @doc """
  Deliver instructions to confirm account.
  """
  def deliver_confirmation_instructions(user, url) do
    Emails.confirmation_instructions(user, url)
  end

  @doc """
  Deliver instructions to reset a user password.
  """
  def deliver_reset_password_instructions(user, url) do
    Emails.reset_password_instructions(user, url)
  end

  @doc """
  Deliver instructions to update a user email.
  """
  def deliver_update_email_instructions(user, url) do
    Emails.update_email_instructions(user, url)
  end
end
