defmodule EasyBillsWeb.HomeLiveTest do
  use EasyBillsWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "Home page" do
    test "renders home page", %{conn: conn} do
      {:ok, _lv, html} = live(conn, ~p"/")

      assert html =~ "Continue with Google"
      assert html =~ "Continue with email"
      assert html =~ "Sign up"
      assert html =~ "By creating an account, you agree to EasyBills Company"
    end
  end

  describe "sign in and sign up navigation" do
    test "redirects to login page when the continue with email button is clicked", %{
      conn: conn
    } do
      {:ok, lv, _html} = live(conn, ~p"/")

      {:ok, conn} =
        lv
        |> element(~s|main a:fl-contains("Continue with email")|)
        |> render_click()
        |> follow_redirect(conn, ~p"/login")

      assert conn.resp_body =~ "Sign in to EasyBills"
      assert conn.resp_body =~ "Don't have an account?"
    end

    test "redirects to the registration page when the sign up button is clicked", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/")

      {:ok, conn} =
        lv
        |> element(~s|main a:fl-contains("Sign up")|)
        |> render_click()
        |> follow_redirect(conn, ~p"/register")

      assert conn.resp_body =~ "Create an account"
      assert conn.resp_body =~ "Sign Up"
      assert conn.resp_body =~ "Begin creating invoices for free!"
    end
  end
end
