defmodule EasyBillsWeb.UserLoginLive do
  @moduledoc false

  use EasyBillsWeb, :live_view

  alias EasyBillsWeb.CoreComponents

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
      <.link navigate={~p"/"} class="flex text-purple-600 mt-8 ml-3">
        <CoreComponents.back_icon /> <span class="mt-[-2px]">Back</span>
      </.link>
      <div class="lg:w-[26%] space-y-6 mx-auto">
        <div class="flex mt-16">
          <CoreComponents.logo_icon />
          <h2 class="text-6xl font-bold ml-3 text-purple-600 mt-3">EasyBills</h2>
        </div>
        <.header class="text-center">
          Sign in to EasyBills
        </.header>

        <.simple_form for={@form} id="login_form" action={~p"/login"} phx-update="ignore">
          <.input field={@form[:email]} type="email" label="Email" required />
          <.input field={@form[:password]} type="password" label="Password" required />

          <:actions>
            <.input field={@form[:remember_me]} type="checkbox" label="Remember me" />
            <.link href={~p"/reset_password"} class="text-sm font-semibold">
              Forgot password?
            </.link>
          </:actions>
          <:actions>
            <.button phx-disable-with="Signing in..." class="w-full bg-purple-500">
              Continue
            </.button>
          </:actions>
        </.simple_form>

        <p>
          Don't have an account?
          <.link navigate={~p"/register"} class="font-semibold text-purple-400 hover:underline">
            Sign up
          </.link>
        </p>
        <div class="w-full flex items-center justify-between py-5">
          <hr class="w-full bg-gray-400" />
          <p class="text-base font-medium leading-4 px-2.5 text-gray-400">Or</p>
          <hr class="w-full bg-gray-400" />
        </div>
        <button
          aria-label="Continue with google"
          role="button"
          class="focus:outline-none focus:ring-2 focus:ring-offset-1 focus:ring-gray-700 py-3.5 px-4 border rounded-lg border-gray-700 flex items-center w-full mt-10"
        >
          <svg
            width="19"
            height="20"
            viewBox="0 0 19 20"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              d="M18.9892 10.1871C18.9892 9.36767 18.9246 8.76973 18.7847 8.14966H9.68848V11.848H15.0277C14.9201 12.767 14.3388 14.1512 13.047 15.0812L13.0289 15.205L15.905 17.4969L16.1042 17.5173C17.9342 15.7789 18.9892 13.221 18.9892 10.1871Z"
              fill="#4285F4"
            />
            <path
              d="M9.68813 19.9314C12.3039 19.9314 14.4999 19.0455 16.1039 17.5174L13.0467 15.0813C12.2286 15.6682 11.1306 16.0779 9.68813 16.0779C7.12612 16.0779 4.95165 14.3395 4.17651 11.9366L4.06289 11.9465L1.07231 14.3273L1.0332 14.4391C2.62638 17.6946 5.89889 19.9314 9.68813 19.9314Z"
              fill="#34A853"
            />
            <path
              d="M4.17667 11.9366C3.97215 11.3165 3.85378 10.6521 3.85378 9.96562C3.85378 9.27905 3.97215 8.6147 4.16591 7.99463L4.1605 7.86257L1.13246 5.44363L1.03339 5.49211C0.37677 6.84302 0 8.36005 0 9.96562C0 11.5712 0.37677 13.0881 1.03339 14.4391L4.17667 11.9366Z"
              fill="#FBBC05"
            />
            <path
              d="M9.68807 3.85336C11.5073 3.85336 12.7344 4.66168 13.4342 5.33718L16.1684 2.59107C14.4892 0.985496 12.3039 0 9.68807 0C5.89885 0 2.62637 2.23672 1.0332 5.49214L4.16573 7.99466C4.95162 5.59183 7.12608 3.85336 9.68807 3.85336Z"
              fill="#EB4335"
            />
          </svg>
          <p class="text-base font-medium ml-4 text-gray-700">Login with Google</p>
        </button>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    email = live_flash(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end
