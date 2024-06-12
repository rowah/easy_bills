defmodule EasyBillsWeb.OnboardingLive.UserRegistration.New do
  @moduledoc false

  use EasyBillsWeb, :live_component

  alias EasyBillsWeb.CommonComponents.Icons
  alias EasyBillsWeb.CoreComponents
  alias EasyBillsWeb.OnboardingLive.Shared.NewPasswordInputComponent
  alias EasyBillsWeb.OnboardingLive.Shared.RegularTemplate

  @impl Phoenix.LiveComponent
  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  @impl Phoenix.LiveComponent
  def render(assigns) do
    ~H"""
    <div>
      <RegularTemplate.regular socket={@socket}>
        <div class="md:w-[30%] mx-auto mt-16 h-[100vh]">
          <.link
            href={~p"/"}
            id="back-icon"
            class="flex text-purple-600 absolute mt-[-6%] lg:mt-[-2%] lg:ml-[-8%]"
          >
            <CoreComponents.back_icon /> <span class="mt-[-2px] ml-1">Back</span>
          </.link>
          <div class="flex mb-6 hidden lg:block">
            <div class="flex">
              <Icons.logo_icon />
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
            class="mt-[-20px]"
          >
            <.error :if={@check_errors}>
              Oops, something went wrong! Please check the errors below.
            </.error>

            <div class="lg:flex justify-between">
              <div class="sm:mb-4 lg:mb-0">
                <.input
                  field={@form[:name]}
                  type="text"
                  label="Name"
                  placeholder="Enter Your Name"
                  required
                />
              </div>
              <.input
                field={@form[:username]}
                type="text"
                label="Username"
                placeholder="Enter Your Username"
                required
              />
            </div>
            <.input
              field={@form[:email]}
              type="email"
              label="Email"
              placeholder="Enter Your Email"
              required
            />
            <div class="relative">
              <%!-- <.input
                field={@form[:password]}
                type="password"
                label="Password"
                placeholder="Enter Your Password"
                required
              /> --%>
              <NewPasswordInputComponent.new_password_input form={@form} />
            </div>

            <label class="flex left-0 flex-row-reverse items-center justify-between">
              <span>
                I agree with EasyBills' <.link>Terms of Use</.link> and <.link>Privacy Policy</.link>
              </span>
              <.input field={@form[:policy_and_terms]} type="checkbox" />
            </label>

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
      </RegularTemplate.regular>
    </div>
    """
  end
end