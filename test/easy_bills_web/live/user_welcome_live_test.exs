defmodule EasyBillsWeb.UserWelcomeLiveTest do
  use EasyBillsWeb.ConnCase

  import Phoenix.LiveViewTest
  import EasyBills.AccountsFixtures

  describe "welcome page" do
    test "renders welcome page", %{conn: conn} do
      {:ok, _lv, html} =
        conn
        |> log_in_user(user_fixture())
        |> live(~p"/welcome")

      assert html =~ "Welcome! Let&#39;s create your profile"
      assert html =~ "Just a few more steps..."
      assert html =~ "Add an avatar"
    end
  end
end
