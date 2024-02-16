defmodule EasyBillsWeb.InvoicesLiveTest do
  use EasyBillsWeb.ConnCase

  import Phoenix.LiveViewTest
  import EasyBills.AccountsFixtures

  describe "invoices page" do
    test "renders invoices page", %{conn: conn} do
      {:ok, _lv, html} =
        conn
        |> log_in_user(user_fixture())
        |> live(~p"/invoices")

      assert html =~ "INVOICES"
      assert html =~ "Log out"
      assert html =~ "Settings"
    end
  end
end
