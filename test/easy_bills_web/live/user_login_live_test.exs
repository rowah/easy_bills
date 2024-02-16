defmodule EasyBillsWeb.UserLoginLiveTest do
  use EasyBillsWeb.ConnCase

  import Phoenix.LiveViewTest
  import EasyBills.AccountsFixtures

  describe "Log in page" do
    test "renders log in page", %{conn: conn} do
      {:ok, _lv, html} = live(conn, ~p"/login")

      assert html =~ "Continue"
      assert html =~ "Sign up"
      assert html =~ "Forgot password?"
    end

    test "redirects if already logged in", %{conn: conn} do
      result =
        conn
        |> log_in_user(user_fixture())
        |> live(~p"/login")
        |> follow_redirect(conn, "/welcome")

      assert {:ok, _conn} = result
    end
  end

  describe "user login" do
    test "redirects if user login with valid credentials", %{conn: conn} do
      password = "123456789abcD"
      user = user_fixture(%{password: password})

      {:ok, lv, _html} = live(conn, ~p"/login")

      form =
        form(lv, "#login_form", user: %{email: user.email, password: password, remember_me: true})

      conn = submit_form(form, conn)

      assert redirected_to(conn) == ~p"/welcome"
    end

    test "redirects to login page with a flash error if there are no valid credentials", %{
      conn: conn
    } do
      {:ok, lv, _html} = live(conn, ~p"/login")

      form =
        form(lv, "#login_form",
          user: %{email: "test@email.com", password: "123456", remember_me: true}
        )

      conn = submit_form(form, conn)

      assert Phoenix.Flash.get(conn.assigns.flash, :error) == "Invalid email or password"

      assert redirected_to(conn) == "/login"
    end
  end

  describe "login navigation" do
    test "redirects to registration page when the Register button is clicked", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/login")

      {:ok, _login_live, login_html} =
        lv
        |> element(~s|main a:fl-contains("Sign up")|)
        |> render_click()
        |> follow_redirect(conn, ~p"/register")

      assert login_html =~ "Sign Up"
    end

    test "redirects to forgot password page when the Forgot Password button is clicked", %{
      conn: conn
    } do
      {:ok, lv, _html} = live(conn, ~p"/login")

      {:ok, conn} =
        lv
        |> element(~s|main a:fl-contains("Forgot password?")|)
        |> render_click()
        |> follow_redirect(conn, ~p"/reset_password")

      assert conn.resp_body =~ "Forgot password?"
    end

    test "redirects to landing page when the back icon is clicked", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/login")

      {:ok, conn} =
        lv
        |> element(~s|main a:fl-contains("Back")|)
        |> render_click()
        |> follow_redirect(conn, ~p"/")

      assert conn.resp_body =~ "Sign in to EasyBills"
    end
  end
end
