defmodule EasyBillsWeb.UserWelcomeLiveTest do
  use EasyBillsWeb.ConnCase

  import Phoenix.LiveViewTest
  import EasyBills.AccountsFixtures

  def upload_image(lv) do
    lv
    |> file_input("#upload-form", :avatar_url, [
      %{
        name: "avatar.jpeg",
        content: File.read!("priv/static/images/avatar.jpeg"),
        size: File.stat!("priv/static/images/avatar.jpeg").size,
        type: "image/jpeg"
      }
    ])
  end

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

  describe "update avatar upload form" do
    setup %{conn: conn} do
      password = valid_user_password()
      user = user_fixture(%{password: password})
      %{conn: log_in_user(conn, user), user: user, password: password}
    end

    test "user uploads and previews avatar", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/welcome")

      uploaded_image = upload_image(lv)

      avatar = uploaded_image.entries |> List.first() |> Map.get("name")
      assert avatar =~ "avatar.jpeg"
    end

    test "redirects to address page on avatar upload form submission", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/welcome")

      uploaded_image = upload_image(lv)

      {:ok, _lv, html} =
        lv
        |> form("#upload-form", avatar_url: uploaded_image)
        |> render_submit()
        |> follow_redirect(conn, ~p"/address")

      assert html =~ "Enter your business address details"
      assert html =~ "Street Address"
      assert html =~ "Postal Address"
    end
  end
end
