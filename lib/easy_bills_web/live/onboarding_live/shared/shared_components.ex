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

  @spec password_criteria_icon(assigns()) :: output()
  def password_criteria_icon(assigns) do
    ~H"""
    <svg
      width="14"
      height="10"
      viewBox="0 0 14 10"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      class={@class}
    >
      <path
        d="M12.3334 1.66675L5.00008 9.00008L1.66675 5.66675"
        stroke={@stroke_color}
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </svg>
    """
  end

  attr :class, :string, default: nil

  @spec password_criteria_not_met_icon(assigns()) :: output()
  def password_criteria_not_met_icon(assigns) do
    ~H"""
    <svg
      width="16"
      height="16"
      viewBox="0 0 16 16"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      class={@class}
    >
      <path
        d="M12 4L4 12"
        stroke="#FE888D"
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
      <path
        d="M4 4L12 12"
        stroke="#FE888D"
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </svg>
    """
  end
end