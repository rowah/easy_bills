defmodule EasyBillsWeb.IconsComponent do
  @moduledoc false
  use EasyBillsWeb, :html

  @type assigns() :: map()
  @type output() :: Phoenix.LiveView.Rendered.t()

  @spec logo_icon(assigns) :: output()
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

  @spec back_icon(assigns) :: Phoenix.LiveView.Rendered.t()
  def back_icon(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      fill="none"
      viewBox="0 0 24 24"
      stroke-width="1.5"
      stroke="currentColor"
      class="w-6 h-6"
    >
      <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5 8.25 12l7.5-7.5" />
    </svg>
    """
  end

  def user_avatar(assigns) do
    ~H"""
    <!-- icon666.com - MILLIONS vector ICONS FREE -->
    <svg
      id="Layer_1"
      enable-background="new 0 0 500 500"
      viewBox="0 0 500 500"
      xmlns="http://www.w3.org/2000/svg"
      class="w-10"
    >
      <g>
        <g>
          <path d="m250 261.5c-29.2 0-52.9-23.7-52.9-52.9s23.7-52.9 52.9-52.9 52.9 23.7 52.9 52.9-23.7 52.9-52.9 52.9zm0-102.8c-27.5 0-49.9 22.4-49.9 49.9s22.4 49.9 49.9 49.9 49.9-22.4 49.9-49.9-22.4-49.9-49.9-49.9z" />
        </g>
        <path d="m250 96.3c-78.9 0-143 64.1-143 143s64.1 143 143 143 143-64.1 143-143-64.1-143-143-143zm0 3c77.2 0 140 62.8 140 140 0 32.9-11.4 63.1-30.4 87-22.7-30.7-64.5-49.7-109.6-49.7s-86.8 19-109.5 49.8c-19.1-23.9-30.5-54.2-30.5-87.1 0-77.1 62.8-140 140-140zm0 280c-43.2 0-81.9-19.7-107.6-50.5 22-30.4 63.1-49.2 107.6-49.2s85.6 18.8 107.6 49.1c-25.7 31-64.4 50.6-107.6 50.6z" />
      </g>
    </svg>
    """
  end
end
