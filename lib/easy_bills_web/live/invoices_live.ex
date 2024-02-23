defmodule EasyBillsWeb.InvoicesLive do
  use EasyBillsWeb, :live_view

  alias EasyBillsWeb.CoreComponents

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div class="bg-white">
      <nav class="bg-black flex flex-col absolute w-58 h-full justify-between rounded-r-3xl">
        <CoreComponents.logo_icon_white />
        <div class="space-x-auto">
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
          <div class="border-b-2 mb-6 text-white">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke-width="1.5"
              stroke="currentColor"
              class="w-6 h-6 mx-auto mb-4"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                d="M21.752 15.002A9.72 9.72 0 0 1 18 15.75c-5.385 0-9.75-4.365-9.75-9.75 0-1.33.266-2.597.748-3.752A9.753 9.753 0 0 0 3 11.25C3 16.635 7.365 21 12.75 21a9.753 9.753 0 0 0 9.002-5.998Z"
              />
            </svg>
          </div>

          <img
            src={@current_user.avatar_url}
            alt={"#{@current_user.username}'s" <> " Avatar"}
            class="rounded-full h-20 w-20 mx-auto mb-6"
          />
        </div>
      </nav>
      <main class="p-5 h-[100vh] text-center text-2xl font-bold tracking-tight text-black">
        <div>
          <div>
            <h2>Invoices</h2>
            <h6>No invoices</h6>
          </div>
        </div>
      </main>
    </div>
    """
  end
end
