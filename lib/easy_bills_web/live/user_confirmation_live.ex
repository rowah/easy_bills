defmodule EasyBillsWeb.UserConfirmationLive do
  use EasyBillsWeb, :live_view

  alias EasyBills.Accounts
  alias EasyBillsWeb.CoreComponents

  def render(%{live_action: :edit} = assigns) do
    ~H"""
    <div class="mx-auto max-w-lg">
      <CoreComponents.logo_icon />
      <.header class="">Hi, username</.header>
      <p>Welcome to EasyBills,</p>
      <hr />
      <p class="mb-6">Please take a second to confirm email as your email address:</p>
      <p>
        Once you do, you will be able to opt-in to notifications of activity and access other features that require a valid email address.
      </p>
      <.simple_form for={@form} id="confirmation_form" phx-submit="confirm_account">
        <.input field={@form[:token]} type="hidden" />
        <:actions>
          <.button phx-disable-with="Confirming..." class="w-1/2 bg-purple-600">
            Confirm email
          </.button>
        </:actions>
      </.simple_form>
      <p class="mt-6">Hight fives, <br /> team EasyBills</p>

      <p class="text-center mt-4">
        <.link href={~p"/register"}>Register</.link> | <.link href={~p"/login"}>Log in</.link>
      </p>
    </div>
    """
  end

  def mount(%{"token" => token}, _session, socket) do
    form = to_form(%{"token" => token}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: nil]}
  end

  # Do not log in the user after confirmation to avoid a
  # leaked token giving the user access to the account.
  def handle_event("confirm_account", %{"user" => %{"token" => token}}, socket) do
    case Accounts.confirm_user(token) do
      {:ok, _} ->
        {:noreply,
         socket
         |> put_flash(:info, "User confirmed successfully.")
         |> redirect(to: ~p"/")}

      :error ->
        # If there is a current user and the account was already confirmed,
        # then odds are that the confirmation link was already visited, either
        # by some automation or by the user themselves, so we redirect without
        # a warning message.
        case socket.assigns do
          %{current_user: %{confirmed_at: confirmed_at}} when not is_nil(confirmed_at) ->
            {:noreply, redirect(socket, to: ~p"/")}

          %{} ->
            {:noreply,
             socket
             |> put_flash(:error, "User confirmation link is invalid or it has expired.")
             |> redirect(to: ~p"/")}
        end
    end
  end
end
