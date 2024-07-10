defmodule EasyBillsWeb.SettingsComponents.EmailNotificationsComponent do
  @moduledoc false

  use EasyBillsWeb, :live_component

  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl Phoenix.LiveComponent
  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  @impl Phoenix.LiveComponent
  def render(assigns) do
    ~H"""
    <div>
      <h1><%= @title %></h1>
    </div>
    """
  end
end
