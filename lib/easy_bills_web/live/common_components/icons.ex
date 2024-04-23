defmodule EasyBillsWeb.CommonComponents.Icons do
  @moduledoc false

  use EasyBillsWeb, :html

  def logo_icon(assigns) do
    ~H"""
    <svg width="85" height="80" viewBox="0 0 85 80" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path
        fill-rule="evenodd"
        clip-rule="evenodd"
        d="M22.1763 0.108887L42.4672 40.6907L62.7581 0.109081C75.9694 7.30834 84.934 21.3193 84.934 37.424C84.934 60.8779 65.9209 79.891 42.467 79.891C19.0131 79.891 0 60.8779 0 37.424C0 21.3191 8.96477 7.30809 22.1763 0.108887Z"
        fill="#7C5DFA"
      />
    </svg>
    """
  end

  def logo_icon_white(assigns) do
    ~H"""
    <svg width="103" height="103" viewBox="0 0 103 103" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path
        d="M0 0H83C94.0457 0 103 8.9543 103 20V83C103 94.0457 94.0457 103 83 103H0V0Z"
        fill="#7C5DFA"
      />
      <mask
        id="mask0_1_34"
        style="mask-type:luminance"
        maskUnits="userSpaceOnUse"
        x="0"
        y="0"
        width="103"
        height="103"
      >
        <path
          d="M0 0H83C94.0457 0 103 8.9543 103 20V83C103 94.0457 94.0457 103 83 103H0V0Z"
          fill="white"
        />
      </mask>
      <g mask="url(#mask0_1_34)">
        <path
          d="M103 52H20C8.95431 52 0 60.9543 0 72V135C0 146.046 8.95431 155 20 155H103V52Z"
          fill="#9277FF"
        />
      </g>
      <path
        fill-rule="evenodd"
        clip-rule="evenodd"
        d="M42.6942 33.2922L52 51.9999L61.3058 33.2922C67.6645 36.6407 72 43.314 72 50.9999C72 62.0456 63.0457 70.9999 52 70.9999C40.9543 70.9999 32 62.0456 32 50.9999C32 43.314 36.3355 36.6407 42.6942 33.2922Z"
        fill="white"
      />
    </svg>
    """
  end

  def white_background_plus_icon(assigns) do
    ~H"""
    <svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
      <circle cx="16" cy="16" r="16" fill="white" />
      <path
        d="M17.3131 21.0229V17.3131H21.0229V14.7328H17.3131V11.0229H14.7328V14.7328H11.0229V17.3131H14.7328V21.0229H17.3131Z"
        fill="#7C5DFA"
      />
    </svg>
    """
  end
end
