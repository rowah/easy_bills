defmodule EasyBillsWeb.UserRegistrationLiveTest do
  use EasyBillsWeb.ConnCase

  import Phoenix.LiveViewTest
  import EasyBills.AccountsFixtures

  describe "Registration page" do
    test "renders registration page", %{conn: conn} do
      {:ok, _lv, html} = live(conn, ~p"/register")

      assert html =~ "Sign Up"
      assert html =~ "Sign Up"
    end

    test "redirects if already logged in", %{conn: conn} do
      result =
        conn
        |> log_in_user(user_fixture())
        |> live(~p"/register")
        |> follow_redirect(conn, "/welcome")

      assert {:ok, _conn} = result
    end

    test "renders errors for invalid data", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/register")

      result =
        lv
        |> element("#registration_form")
        |> render_change(user: %{"email" => "with spaces", "password" => "2Short!"})

      assert result =~ "Sign Up"
      assert result =~ "Please enter a valid email address"
      assert result =~ "8+ characters"
    end
  end

  describe "register user" do
    test "creates account and directs user to check their email to confirm their email address",
         %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/register")
      email = unique_user_email()

      result =
        lv
        |> form("#registration_form", user: valid_user_attributes(email: email))
        |> render_submit()

      assert result =~ "Please follow the link in the message to confirm your email address"
      assert result =~ "Resend Confirmation Instruction"
    end

    test "renders errors for duplicated email", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/register")

      user = user_fixture(%{email: "test@email.com"})

      result =
        lv
        |> form("#registration_form",
          user: %{"email" => user.email, "password" => "valid_password"}
        )
        |> render_submit()

      assert result =~ "has already been taken"
    end

    test "warns user of invalid email during registration", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/register")

      html =
        lv
        |> form("#registration_form",
          user: %{"email" => "emailwithoutatsign", "password" => "valid_password"}
        )
        |> render_change()

      assert html =~ "Please enter a valid email address"
    end

    test "warns user of a weak password", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/register")

      user = user_fixture(%{email: "test1@email.com"})

      html =
        lv
        |> form("#registration_form",
          user: %{"email" => user.email, "password" => "n"}
        )
        |> render_change()

      assert html =~ "special character"
      assert html =~ "upper- case character"
      assert html =~ "number"
      assert html =~ "8+ characters"
    end
  end

  describe "registration navigation" do
    test "redirects to login page when the Log in button is clicked", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/register")

      {:ok, _login_live, login_html} =
        lv
        |> element(~s|main a:fl-contains("Sign in")|)
        |> render_click()
        |> follow_redirect(conn, ~p"/login")

      assert login_html =~ "Continue"
    end

    test "redirects to previous page when the back icon is clicked", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/register")

      {:ok, conn} =
        lv
        |> element("#back-icon")
        |> render_click()
        |> follow_redirect(conn, ~p"/")

      assert conn.resp_body =~ "Sign in to EasyBills"
    end
  end
end
