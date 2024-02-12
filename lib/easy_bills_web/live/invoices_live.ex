defmodule EasyBillsWeb.InvoicesLive do
  use EasyBillsWeb, :live_view

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <main class="p-5 h-[100vh] text-center text-2xl bg-black font-bold tracking-tight text-white">
      INVOICES
    </main>
    """
  end
end
