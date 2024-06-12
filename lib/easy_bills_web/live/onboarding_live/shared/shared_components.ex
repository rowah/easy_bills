defmodule EasyBillsWeb.OnboardingLive.Shared.SharedComponents do
  @moduledoc false
  use EasyBillsWeb, :html

  @type assigns :: map()
  @type output :: Phoenix.LiveView.Rendered.t()

  def registration_success_page(assigns) do
    ~H"""
    <div
      id="confirmation_instructions"
      class="relative flex min-h-screen flex-col items-center justify-center overflow-hidden py-6 sm:py-12 bg-white"
    >
      <div class="max-w-xl px-5 text-center bg-purple-200 rounded-lg">
        <h2 class="mb-2 text-[42px] font-bold text-zinc-800"><%= @title %></h2>
        <p class="mb-2 text-lg text-zinc-500 leading-loose">
          We've sent a confirmation email to <span class="font-medium text-indigo-500"><%= @form.data.email %></span>. Please follow the link in the message to confirm your email address. If you did not receive the email, please check your spam folder or:
        </p>
        <.button
          phx-click="resend_confirmation"
          phx-disable-with="Resending link..."
          class="w-full mb-12"
        >
          Resend Confirmation Instruction
        </.button>
      </div>
    </div>
    """
  end
end
