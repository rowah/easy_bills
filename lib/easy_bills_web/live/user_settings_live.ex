defmodule EasyBillsWeb.UserSettingsLive do
  use EasyBillsWeb, :live_view

  alias EasyBills.Accounts
  alias EasyBillsWeb.CommonComponents.NavComponent
  alias EasyBillsWeb.SettingsComponents.EditBioComponent
  alias EasyBillsWeb.SettingsComponents.EditPasswordComponent
  alias EasyBillsWeb.SettingsComponents.EmailNotificationsComponent

  @impl Phoenix.LiveView
  def render(%{live_action: :edit_bio} = assigns) do
    ~H"""
    <div class="bg-gray-100 min-h-screen">
      <NavComponent.navbar current_user={@current_user} />

      <div class="mx-auto w-1/2 py-8">
        <.header class="text-[1.5rem]">
          Settings
        </.header>
        <div class="flex justify-between w-[36%] mt-3 text-sm mb-8">
          <.link patch={~p"/settings"} class="focus:text-purple-500">
            Personal
          </.link>
          <.link patch={~p"/settings/edit_password"} class="focus:text-purple-500">
            Password
          </.link>
          <.link patch={~p"/settings/edit_email_notifications"} class="focus:text-purple-500">
            Email Notifications
          </.link>
        </div>
        <div class="space-y-12 divide-y bg-white p-10 rounded-lg">
          <.live_component
            module={EditBioComponent}
            id={@current_user.id}
            current_user={@current_user}
            action={@live_action}
            address_form={@address_form}
            email_form={@email_form}
            title={@page_title}
            email_form_current_password={@email_form_current_password}
            trigger_submit={@trigger_submit}
            current_email={@current_email}
          />
        </div>
      </div>
    </div>
    """
  end

  def render(%{live_action: :edit_password} = assigns) do
    ~H"""
    <div class="bg-gray-100 min-h-screen">
      <NavComponent.navbar current_user={@current_user} />
      <div class="mx-auto w-1/2 py-8">
        <.header class="text-[1.5rem]">
          Settings
        </.header>
        <div class="flex justify-between w-[36%] mt-3 text-sm mb-8">
          <.link patch={~p"/settings"} class="focus:text-purple-500">
            Personal
          </.link>
          <.link patch={~p"/settings/edit_password"} class="focus:text-purple-500">Password</.link>
          <.link patch={~p"/settings/edit_email_notifications"} class="focus:text-purple-500">
            Email Notifications
          </.link>
        </div>
        <div class="space-y-12 divide-y bg-white p-10 rounded-lg">
          <.live_component
            module={EditPasswordComponent}
            id={@current_user.id}
            current_user={@current_user}
            email_form={@email_form}
            action={@live_action}
            title={@page_title}
            password_form={@password_form}
            trigger_submit={@trigger_submit}
            current_password={@current_password}
            current_email={@current_email}
          />
        </div>
      </div>
    </div>
    """
  end

  def render(%{live_action: :edit_email_notifications} = assigns) do
    ~H"""
    <div class="bg-gray-100 min-h-screen">
      <NavComponent.navbar current_user={@current_user} />
      <div class="mx-auto w-1/2 py-12">
        <.header class="text-[1.5rem]">
          Settings
        </.header>
        <div class="flex justify-between w-[36%] mt-3 text-sm mb-8">
          <.link patch={~p"/settings"} class="focus:text-purple-500">
            Personal
          </.link>
          <.link patch={~p"/settings/edit_password"} class="focus:text-purple-500">
            Password
          </.link>
          <.link patch={~p"/settings/edit_email_notifications"} class="focus:text-purple-500">
            Email Notifications
          </.link>
        </div>
        <div class="space-y-12 divide-y bg-white p-10 rounded-lg">
          <.live_component
            module={EmailNotificationsComponent}
            id={@current_user.id}
            current_user={@current_user}
            email_notifications_form={@email_notifications_form}
            email_form={@email_form}
            action={@live_action}
            title={@page_title}
            trigger_submit={@trigger_submit}
          />
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def mount(%{"token" => token}, _session, socket) do
    socket =
      case Accounts.update_user_email(socket.assigns.current_user, token) do
        :ok ->
          put_flash(socket, :info, "Email changed successfully.")

        :error ->
          put_flash(socket, :error, "Email change link is invalid or it has expired.")
      end

    {:ok, push_navigate(socket, to: ~p"/settings")}
  end

  def mount(_params, _session, socket) do
    user = socket.assigns.current_user
    email_changeset = Accounts.change_user_email(user)

    password_changeset =
      Accounts.change_user_password(user)

    address_changeset =
      Accounts.change_user_address(user)

    # notifications_changeset =
    # Accounts.change_user_notifications(user) |> IO.inspect(label: "notifications_changeset")

    socket =
      socket
      |> assign(:current_password, nil)
      |> assign(:email_form_current_password, nil)
      |> assign(:current_email, user.email)
      |> assign(:address_form, to_form(address_changeset))
      |> assign(:email_form, to_form(email_changeset))
      |> assign(:email_notifications_form, to_form(email_changeset))
      |> assign(:password_form, to_form(password_changeset))
      |> assign(:trigger_submit, false)

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_event("validate_email", params, socket) do
    %{"current_password" => password, "user" => user_params} = params

    email_form =
      socket.assigns.current_user
      |> Accounts.change_user_email(user_params)
      |> Map.put(:action, :validate)
      |> to_form()

    {:noreply, assign(socket, email_form: email_form, email_form_current_password: password)}
  end

  def handle_event("update_email", params, socket) do
    %{"current_password" => password, "user" => user_params} = params
    user = socket.assigns.current_user

    case Accounts.apply_user_email(user, password, user_params) do
      {:ok, applied_user} ->
        Accounts.deliver_user_update_email_instructions(
          applied_user,
          user.email,
          &url(~p"/settings/confirm_email/#{&1}")
        )

        info = "A link to confirm your email change has been sent to the new address."
        {:noreply, socket |> put_flash(:info, info) |> assign(email_form_current_password: nil)}

      {:error, changeset} ->
        {:noreply, assign(socket, :email_form, to_form(Map.put(changeset, :action, :insert)))}
    end
  end

  def handle_event("validate_password", params, socket) do
    %{"current_password" => password, "user" => user_params} = params

    password_form =
      socket.assigns.current_user
      |> Accounts.change_user_password(user_params)
      |> Map.put(:action, :validate)
      |> to_form()

    {:noreply, assign(socket, password_form: password_form, current_password: password)}
  end

  def handle_event("update_password", params, socket) do
    %{"current_password" => password, "user" => user_params} = params
    user = socket.assigns.current_user

    case Accounts.update_user_password(user, password, user_params) do
      {:ok, user} ->
        password_form =
          user
          |> Accounts.change_user_password(user_params)
          |> to_form()

        {:noreply, assign(socket, trigger_submit: true, password_form: password_form)}

      {:error, changeset} ->
        {:noreply, assign(socket, password_form: to_form(changeset))}
    end
  end

  def handle_event("delete_account", _params, socket) do
    user = socket.assigns.current_user

    case Accounts.delete_user(user) do
      {:ok, _user} ->
        {:noreply,
         socket
         |> put_flash(:info, "Your account has been deleted.")
         |> push_navigate(to: ~p"/")}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp apply_action(socket, :edit_bio, _params) do
    socket
    |> assign(:page_title, "Edit Profile Information")
  end

  defp apply_action(socket, :edit_password, _params) do
    socket
    |> assign(:page_title, "Change Password")
  end

  defp apply_action(socket, :edit_email_notifications, _params) do
    socket
    |> assign(:page_title, "Edit Notification Preferences")
  end
end
