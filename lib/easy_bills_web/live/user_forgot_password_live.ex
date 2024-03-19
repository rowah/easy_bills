defmodule EasyBillsWeb.UserForgotPasswordLive do
  use EasyBillsWeb, :live_view

  alias EasyBills.Accounts
  alias EasyBillsWeb.CoreComponents
  alias EasyBillsWeb.CommonComponents.LogoIcons

  def render(assigns) do
    ~H"""
    <div class="flex">
      <div class="w-1/2 h-screen hidden lg:block">
        <img
          src={~p"/images/section-invoice.png"}
          alt="Placeholder Image"
          class="object-cover w-full h-full"
        />
      </div>
      <div class="my-auto mx-auto space-y-16 max-w-md">
        <.link
          href={~p"/login"}
          id="back-icon"
          class="flex text-purple-600 absolute ml-[-8%] mt-6 lg:mt-[-4%]"
        >
          <CoreComponents.back_icon /> <span class="mt-[-2px] ml-1">Back</span>
        </.link>
        <div class="flex mt-16">
          <LogoIcons.logo_icon />
          <h2 class="text-6xl font-bold ml-3 text-purple-600 mt-3">EasyBills</h2>
        </div>
        <.header class="text-center">
          Forgot password?
          <:subtitle>
            <b>Enter the email</b>
            that you used to create your account and we will send you a
            <b>link to reset your password</b>
          </:subtitle>
        </.header>

        <.simple_form for={@form} id="reset_password_form" phx-submit="send_email">
          <.input field={@form[:email]} label="Email" type="email" placeholder="Email" required />
          <:actions>
            <.button phx-disable-with="Sending..." class="w-full">
              Send reset link
            </.button>
          </:actions>
        </.simple_form>
        <p class="text-center text-sm mt-4">
          <.link href={~p"/register"}>Register</.link> | <.link href={~p"/login"}>Log in</.link>
        </p>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{}, as: "user"))}
  end

  def handle_event("send_email", %{"user" => %{"email" => email}}, socket) do
    if user = Accounts.get_user_by_email(email) do
      Accounts.deliver_user_reset_password_instructions(
        user,
        &url(~p"/reset_password/#{&1}")
      )
    end

    info =
      "If your email is in our system, you will receive instructions to reset your password shortly."

    {:noreply,
     socket
     |> put_flash(:info, info)
     |> redirect(to: ~p"/")}
  end
end
