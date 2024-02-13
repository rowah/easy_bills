defmodule EasyBillsWeb.InvoicesLive do
  use EasyBillsWeb, :live_view

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div class="bg-black">
      <nav>
        <p class="text-[0.8125rem] leading-6 text-white">
          <%= @current_user.email %>
        </p>
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
          <img src={@current_user.avatar_url} alt="Image" class="rounded-full h-32 w-32" />
        </p>
      </nav>
      <main class="p-5 h-[100vh] text-center text-2xl font-bold tracking-tight text-white">
        INVOICES
      </main>
    </div>
    """
  end
end
