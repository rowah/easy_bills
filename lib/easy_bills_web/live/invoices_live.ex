defmodule EasyBillsWeb.InvoicesLive do
  use EasyBillsWeb, :live_view

  alias EasyBillsWeb.CommonComponents.Icons

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div class="text-gray-900 dark:text-white bg-white dark:bg-gray_secondary antialiased">
      <nav class="bg-black flex flex-col absolute w-58 h-full justify-between rounded-r-3xl">
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
          <div
            id="theme-toggle"
            phx-click="toggle_dark_mode"
            class="border-b-2 mb-4 pb-2 text-white"
            phx-hook="DarkModeToggle"
          >
            <span id="theme-toggle-light-icon" class="cursor-pointer">
              <.icon name="hero-moon" />
            </span>
            <span id="theme-toggle-dark-icon" class="hidden cursor-pointer">
              <.icon name="hero-sun" />
            </span>
          </div>

          <img
            src={@current_user.avatar_url}
            alt={"#{@current_user.username}'s" <> " Avatar"}
            class="rounded-full h-20 w-20 mx-auto mb-6"
          />
        </div>
      </nav>
      <main class="p-5 h-[100vh] text-center tracking-tight">
        <div class="flex w-1/2 justify-between mx-auto mt-6">
          <div>
            <h2 class="font-bold text-lg">Invoices</h2>
            <h6 class="text-xs font-gray-300">No invoices</h6>
          </div>
          <div class="flex flex-row items-center font-bold">
            <p class="mr-1">Filter by status</p>
            <.icon name="hero-chevron-down" />
            <button class="btn bg-purple-500 rounded-full w-36 h-12 text-white flex items-center justify-between px-2 ml-6">
              <Icons.white_background_plus_icon /> New Invoice
            </button>
          </div>
        </div>
        <EasyBillsWeb.Invoices.EmptyInvoiceBox.empty_inbox />
      </main>
    </div>
    """
  end

  @impl Phoenix.LiveView
  def handle_event("toggle_dark_mode", _value, socket) do
    {:noreply, push_event(socket, "toggle_dark_mode", %{})}
  end
end
