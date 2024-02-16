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
end
