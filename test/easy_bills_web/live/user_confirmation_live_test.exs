defmodule EasyBillsWeb.UserConfirmationLiveTest do
  use EasyBillsWeb.ConnCase

  import Phoenix.LiveViewTest
  import EasyBills.AccountsFixtures

  alias EasyBills.Accounts
  alias EasyBills.Repo

  setup do
    %{user: user_fixture(), user_two: user_two_fixture()}
  end

  describe "Confirm user" do
    test "renders confirmation page and confirms the given token", %{conn: conn, user: user} do
      token =
        extract_user_token(fn url ->
          Accounts.deliver_user_confirmation_instructions(user, url)
        end)

      {:ok, decoded_token} = Base.url_decode64(token, padding: false)
      hashed_token = :crypto.hash(:sha256, decoded_token)

      user = Accounts.get_user_by_confirmation_token(hashed_token)
      updated_assigns = Map.put(conn.assigns, :user, user)

      updated_conn = %{conn | assigns: updated_assigns}

      {:ok, lv, html} =
        updated_conn
        |> live(~p"/confirm/#{token}")

      assert html =~ "Hi, #{user.username}"
      assert html =~ "Confirm email"
      assert html =~ "Please take a second to confirm #{user.email} as your email address"

      # when not logged in
      result =
        lv
        |> form("#confirmation_form")
        |> render_submit()
        |> follow_redirect(updated_conn, "/")

      assert {:ok, updated_conn} = result

      assert Phoenix.Flash.get(updated_conn.assigns.flash, :info) =~
               "User confirmed successfully"

      assert Accounts.get_user!(user.id).confirmed_at
      refute get_session(updated_conn, :user_token)
      assert Repo.all(Accounts.UserToken) == []
    end

    # test "does not confirm email with invalid token", %{conn: conn, user: user_two} do
    #   token =
    #     extract_user_token(fn url ->
    #       Accounts.deliver_user_confirmation_instructions(user, url)
    #     end)

    #   {:ok, decoded_token} = Base.url_decode64(token, padding: false)
    #   hashed_token = :crypto.hash(:sha256, decoded_token)

    #   user = Accounts.get_user_by_confirmation_token(hashed_token)
    #   {:ok, lv, _html} = live(conn, ~p"/confirm/invalid-token")

    #   {:ok, conn} =
    #     lv
    #     |> form("#confirmation_form")
    #     |> render_submit()
    #     |> follow_redirect(conn, ~p"/")

    #   assert Phoenix.Flash.get(conn.assigns.flash, :error) =~
    #            "User confirmation link is invalid or it has expired"

    #   refute Accounts.get_user!(user.id).confirmed_at
    # end
  end
end
