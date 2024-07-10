defmodule EasyBillsWeb.SettingsComponents.EditPasswordComponent do
  @moduledoc false

  use EasyBillsWeb, :live_component

  alias EasyBillsWeb.OnboardingLive.Shared.NewPasswordInputComponent

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
          <%= @current_user.username <> " " <> @current_user.name %> / Password
        </h1>
      </div>
      <h1><%= @title %></h1>
      <div>
        <.simple_form
          for={@password_form}
          id="password_form"
          action={~p"/login?_action=password_updated"}
          method="post"
          phx-change="validate_password"
          phx-submit="update_password"
          phx-trigger-action={@trigger_submit}
        >
          <.input
            field={@password_form[:email]}
            type="hidden"
            id="hidden_user_email"
            value={@current_email}
          />
          <div class="relative">
            <NewPasswordInputComponent.new_password_input form={@password_form} />
          </div>
          <.input
            field={@password_form[:current_password]}
            name="current_password"
            type="password"
            label="Current password"
            id="current_password_for_password"
            value={@current_password}
            required
          />
          <:actions>
            <.button phx-disable-with="Changing...">Change Password</.button>
          </:actions>
        </.simple_form>
      </div>
    </div>
    """
  end
end
