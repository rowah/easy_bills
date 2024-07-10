defmodule EasyBillsWeb.CommonComponents.NavComponent do
  @moduledoc """
  Navigation component
  """

  alias EasyBillsWeb.CommonComponents.Icons

  use EasyBillsWeb, :html

  @type assigns :: map
  @type output :: Phoenix.LiveView.Rendered.t()

  @spec navbar(assigns()) :: output()
  def navbar(assigns) do
    ~H"""
    <div>
      <nav class="bg-black flex flex-col absolute w-58 h-full justify-between z-40 rounded-r-3xl">
        <Icons.logo_icon_white />
        <div class="space-x-auto text-center">
          <div class="border-b-2 mb-4 pb-2 text-white">
            <.icon name="hero-moon" />
            <.icon name="hero-sun" class="hidden" />
          </div>

          <img
            src={@current_user.avatar_url}
            alt={"#{@current_user.username}'s" <> " Avatar"}
            class="rounded-full h-20 w-20 mx-auto mb-6 cursor-pointer"
            phx-click={show_modal("profile-modal")}
          />
        </div>
      </nav>
      <.profile_modal id="profile-modal">
        <div class="text-center rounded-lg ml-[30%]">
          <img
            src={@current_user.avatar_url}
            alt={"#{@current_user.username}'s" <> " Avatar"}
            class="rounded-full h-20 w-20 mx-auto mb-6 cursor-pointer"
            phx-click={show_modal("profile-modal")}
          />
          <h4 class="mb-2 text-lg font-bold text-zinc-800">
            <%= @current_user.username <> " " <> @current_user.name %>
          </h4>
          <div class="flex flex-col space-y-4 ml-24">
            <.link
              navigate={~p"/invoices"}
              class="text-[0.8125rem] leading-6 text-gray-500 font-semibold hover:text-zinc-700"
            >
              <div class="flex items-center space-x-3">
                <Icons.dashboard_icon /> <span>Dashboard</span>
              </div>
            </.link>
            <.link
              navigate={~p"/settings"}
              class="text-[0.8125rem] leading-6 text-gray-500 font-semibold hover:text-zinc-700"
            >
              <div class="flex items-center space-x-3">
                <Icons.settings_icon /> <span>Settings</span>
              </div>
            </.link>
            <.link
              href={~p"/logout"}
              method="delete"
              class="text-[0.8125rem] leading-6 text-gray-500 font-semibold hover:text-zinc-700"
            >
              <div class="flex items-center space-x-3">
                <Icons.sign_out_icon /> <span>Log out</span>
              </div>
            </.link>
          </div>
        </div>
      </.profile_modal>
    </div>
    """
  end
end
