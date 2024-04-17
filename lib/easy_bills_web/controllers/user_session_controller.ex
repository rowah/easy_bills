defmodule EasyBillsWeb.UserSessionController do
  use EasyBillsWeb, :controller

  alias EasyBills.Accounts
  alias EasyBillsWeb.UserAuth
  alias EasyBills.Accounts.User

  def create(conn, %{"_action" => "registered"} = params) do
    create(conn, params, "Account created successfully!")
  end

  def create(conn, %{"_action" => "password_updated"} = params) do
    conn
    |> put_session(:user_return_to, ~p"/settings")
    |> create(params, "Password updated successfully!")
  end

  def create(conn, params) do
    create(conn, params, "Welcome back!")
  end

  defp create(conn, %{"user" => user_params}, info) do
    user_return_to = get_session(conn, :user_return_to)

    %{"email" => email, "password" => password} = user_params

    case Accounts.get_user_by_email_and_password(email, password) do
      %User{avatar_url: nil} = user ->
        conn
        |> put_flash(:info, info)
        |> UserAuth.log_in_user(user, user_params)
        |> redirect(to: user_return_to || ~p"/welcome")

      %User{} = user ->
        conn
        |> put_flash(:info, info)
        |> UserAuth.log_in_user(user, user_params)
        |> redirect(to: user_return_to || ~p"/invoices")

      _ ->
        conn
        |> put_flash(
          :error,
          "We couldn’t find an account matching the email and password you entered. Please crosscheck your email and password and try again"
        )
        |> put_flash(:email, String.slice(email, 0, 160))
        |> redirect(to: ~p"/login")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end
end
