defmodule EasyBillsWeb.UserRegistrationLive do
  use EasyBillsWeb, :live_view

  alias EasyBills.Accounts
  alias EasyBills.Accounts.User
  alias EasyBillsWeb.CoreComponents

  @impl Phoenix.LiveView

  def mount(_params, _session, socket) do
    changeset = Accounts.change_user_registration(%User{})

    socket =
      socket
      |> assign(trigger_submit: false, check_errors: false)
      |> assign_form(changeset)
      |> assign(:template, :new)

    {:ok, socket, temporary_assigns: [form: nil]}
  end

  @impl Phoenix.LiveView
  def render(%{template: :new} = assigns) do
    ~H"""
    <div class="flex">
      <div class="w-1/2 h-screen hidden lg:block">
        <img
          src={~p"/images/section-invoice.png"}
          alt="EasyBills Image"
          class="object-cover w-full h-full"
        />
      </div>
      <.link href={~p"/"} class="flex text-purple-600 mt-8 ml-3">
        <CoreComponents.back_icon /> Back
      </.link>
      <div class="md:w-[30%] mx-auto mt-16">
        <div class="flex mb-14 hidden lg:block">
          <div class="flex">
            <CoreComponents.logo_icon />
            <h2 class="text-6xl font-bold ml-3 text-purple-600 mt-3">EasyBills</h2>
          </div>
        </div>
        <h3 class="text-center font-bold text-3xl">
          Create an account
        </h3>
        <p>Begin creating invoices for free!</p>

        <.simple_form
          for={@form}
          id="registration_form"
          phx-submit="save"
          phx-change="validate"
          phx-trigger-action={@trigger_submit}
          action={~p"/login?_action=registered"}
          method="post"
        >
          <.error :if={@check_errors}>
            Oops, something went wrong! Please check the errors below.
          </.error>

          <div class="lg:flex">
            <div class="lg:mr-6 sm:mb-4 lg:mb-0">
              <.input field={@form[:name]} type="text" label="Name" required />
            </div>
            <.input field={@form[:username]} type="text" label="Username" required />
          </div>
          <.input field={@form[:email]} type="email" label="Email" required />
          <.input field={@form[:password]} type="password" label="Password" required />

          <:actions>
            <.button phx-disable-with="Creating account..." class="w-full">
              Sign Up
            </.button>
          </:actions>
        </.simple_form>
        <p class="mt-6 ml-[20%]">
          Already have an account?
          <.link navigate={~p"/login"} class="font-semibold text-purple-400 hover:underline">
            Sign in
          </.link>
        </p>
      </div>
    </div>
    """
  end

  def render(%{template: :success} = assigns) do
    ~H"""
    <div
      id="confirmation_instructions"
      class="relative flex min-h-screen flex-col items-center justify-center overflow-hidden py-6 sm:py-12 bg-white"
    >
      <div class="max-w-xl px-5 text-center bg-purple-200 rounded-lg">
        <h2 class="mb-2 text-[42px] font-bold text-zinc-800">Confirm your Email Address</h2>
        <p class="mb-2 text-lg text-zinc-500 leading-loose">
          We've sent a confirmation email to <span class="font-medium text-indigo-500">mail@yourdomain.com</span>. Please follow the link in the message to confirm your email address. If you did not receive the email, please check your spam folder or:
        </p>
        <.button phx-disable-with="Resending link..." class="w-full mb-12">
          Resend Confirmation Instruction
        </.button>
      </div>
    </div>
    """
  end

  @impl Phoenix.LiveView
  def handle_event("save", %{"user" => user_params}, socket) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &url(~p"/confirm/#{&1}")
          )

        changeset = Accounts.change_user_registration(user)

        {:noreply,
         socket
         |> assign(trigger_submit: true)
         |> assign_form(changeset)
         |> assign(:template, :success)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign(check_errors: true) |> assign_form(changeset)}
    end
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset = Accounts.change_user_registration(%User{}, user_params)
    {:noreply, assign_form(socket, Map.put(changeset, :action, :validate))}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset, as: "user")

    if changeset.valid? do
      assign(socket, form: form, check_errors: false)
    else
      assign(socket, form: form)
    end
  end
end
