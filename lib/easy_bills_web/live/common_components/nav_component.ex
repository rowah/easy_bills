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
    <nav class="bg-black flex flex-col absolute z-50 w-58 h-full justify-between rounded-r-3xl">
      <Icons.logo_icon_white />
      <div class="space-x-auto text-center">
        <p>
          <.link
            href={~p"/settings"}
            class="text-[0.8125rem] leading-6 text-white font-semibold hover:text-zinc-700"
          >
            Settings
          </.link>
        </p>
        <p>
          <.link
            href={~p"/logout"}
            method="delete"
            class="text-[0.8125rem] leading-6 text-white font-semibold hover:text-white"
          >
            Log out
          </.link>
        </p>
        <button
          phx-click="toggle_dark_mode"
          id="theme-toggle"
          phx-hook="DarkModeToggle"
          class="w-8 h-8 mb-4 text-white text-center hover:bg-gray-700 rounded-full"
        >
          <.icon id="theme-toggle-dark-icon" name="hero-sun" class="w-6 h-6" />
          <.icon id="theme-toggle-light-icon" name="hero-moon" class="hidden w-6 h-6" />
        </button>

        <img
          src={@current_user.avatar_url}
          alt={"#{@current_user.username}'s" <> " Avatar"}
          class="rounded-full h-20 w-20 mx-auto mb-6"
        />
      </div>
    </nav>
    """
  end
end
