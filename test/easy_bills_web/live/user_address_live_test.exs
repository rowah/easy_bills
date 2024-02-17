defmodule EasyBillsWeb.UserAddressLiveTest do
  use EasyBillsWeb.ConnCase

  import Phoenix.LiveViewTest
  import EasyBills.AccountsFixtures

  describe "address page" do
    test "renders address page", %{conn: conn} do
      {:ok, _lv, html} =
        conn
        |> log_in_user(user_fixture())
        |> live(~p"/address")

      assert html =~ "Enter your business address details"
      assert html =~ "Street Address"
      assert html =~ "Postal Address"
      assert html =~ "Save"
    end
  end

  describe "address form" do
    setup %{conn: conn} do
      password = valid_user_password()
      user = user_fixture(%{password: password})
      %{conn: log_in_user(conn, user), user: user, password: password}
    end

    test "fills and submit address form", %{conn: conn} do
      {:ok, lv, _html} =
        conn
        |> log_in_user(user_fixture())
        |> live(~p"/address")

      {:ok, conn} =
        lv
        |> form("#address_form", %{"user" => user_address()})
        |> render_submit()
        |> follow_redirect(conn, ~p"/invoices")

      assert conn.resp_body =~ "Address updated successfully"
      assert conn.resp_body =~ "Invoices"
    end

    test "navigates back to welcome page using back icon", %{conn: conn} do
      {:ok, _lv, _html} =
        conn
        |> log_in_user(user_fixture())
        |> live(~p"/address")
    end
  end
end
