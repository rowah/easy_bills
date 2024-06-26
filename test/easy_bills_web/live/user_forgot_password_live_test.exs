defmodule EasyBillsWeb.UserForgotPasswordLiveTest do
  use EasyBillsWeb.ConnCase

  import Phoenix.LiveViewTest
  import EasyBills.AccountsFixtures

  alias EasyBills.Accounts
  alias EasyBills.Repo

  describe "Forgot password page" do
    test "renders email page", %{conn: conn} do
      {:ok, lv, html} = live(conn, ~p"/reset_password")

      assert html =~ "Forgot password?"
      assert has_element?(lv, ~s|a[href="#{~p"/register"}"]|, "Register")
      assert has_element?(lv, ~s|a[href="#{~p"/login"}"]|, "Log in")
    end

    test "redirects to login page when the back icon is clicked", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/reset_password")

      {:ok, conn} =
        lv
        |> element("#back-icon")
        |> render_click()
        |> follow_redirect(conn, ~p"/login")

      assert conn.resp_body =~ "Continue with google"
    end

    test "redirects if already logged in", %{conn: conn} do
      result =
        conn
        |> log_in_user(user_fixture())
        |> live(~p"/reset_password")
        |> follow_redirect(conn, ~p"/invoices")

      assert {:ok, _conn} = result
    end
  end

  describe "Reset link" do
    setup do
      %{user: user_fixture()}
    end

    test "sends a new reset password token", %{conn: conn, user: user} do
      {:ok, lv, _html} = live(conn, ~p"/reset_password")

      {:ok, conn} =
        lv
        |> form("#reset_password_form", user: %{"email" => user.email})
        |> render_submit()
        |> follow_redirect(conn, "/")

      assert Phoenix.Flash.get(conn.assigns.flash, :info) =~ "If your email is in our system"

      assert Repo.get_by!(Accounts.UserToken, user_id: user.id).context ==
               "reset_password"
    end

    test "does not send reset password token if email is invalid", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/reset_password")

      {:ok, conn} =
        lv
        |> form("#reset_password_form", user: %{"email" => "unknown@example.com"})
        |> render_submit()
        |> follow_redirect(conn, "/")

      assert Phoenix.Flash.get(conn.assigns.flash, :info) =~ "If your email is in our system"
      assert Repo.all(Accounts.UserToken) == []
    end
  end
end
