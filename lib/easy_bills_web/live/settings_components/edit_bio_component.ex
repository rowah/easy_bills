defmodule EasyBillsWeb.SettingsComponents.EditBioComponent do
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
        <h1 class="flex items-center font-bold text-lg ml-4 ">
          <%= @current_user.username <> " " <> @current_user.name %> / Profile Information
        </h1>
      </div>
      <h1><%= @title %></h1>
      <div>
        <.simple_form
          for={@email_form}
          id="email_form"
          phx-submit="update_email"
          phx-change="validate_email"
        >
          <.input field={@email_form[:email]} type="email" label="Email" required />
          <.input
            field={@email_form[:current_password]}
            name="current_password"
            id="current_password_for_email"
            type="password"
            label="Current password"
            value={@email_form_current_password}
            required
          />
          <:actions>
            <div class="text-rose-500 cursor-pointer" phx-click="delete_account">Delete Account</div>
            <.button phx-disable-with="Changing...">Save Changes</.button>
          </:actions>
        </.simple_form>
      </div>
    </div>
    """
  end
end
