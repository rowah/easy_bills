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

      assert html =~ "There is nothing here"
      assert html =~ "No invoices"
      assert html =~ "Create an invoice by clicking the New Invoice button and get started"
    end
  end
end
