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
      <div class="flex">
        <img
          src={@current_user.avatar_url}
          alt={"#{@current_user.username}'s" <> " Avatar"}
          class="rounded-full h-20 w-20 mb-4"
        />
        <h1 class="flex items-center font-bold text-lg ml-4">
          <%= @current_user.username <> " " <> @current_user.name %> / Email Notifications
        </h1>
      </div>
      <h1><%= @title %></h1>
      <h3>I'd like to receive:</h3>
      <.simple_form
        for={@email_notifications_form}
        id="email_form"
        phx-submit="update_email"
        phx-change="validate_email"
      >
        <.input
          field={@email_notifications_form[:name]}
          type="checkbox"
          label="Newsletter and product updates"
          required
        />
        <.input
          field={@email_notifications_form[:name]}
          type="checkbox"
          label="Sign in notifications"
          required
        />
        <.input
          field={@email_notifications_form[:name]}
          type="checkbox"
          label="Due payment reminders"
          required
        />
        <:actions>
          <div class="text-rose-500 cursor-pointer" phx-click="delete_account">Delete Account</div>
          <.button phx-disable-with="Changing...">Change Password</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end
end
