defmodule EasyBillsWeb.OnboardingLive.Shared.RegularTemplate do
  @moduledoc false

  use EasyBillsWeb, :html

  @type assigns :: map()
  @type output :: Phoenix.LiveView.Rendered.t()

  @spec regular(assigns()) :: output()
  def regular(assigns) do
    ~H"""
    <div class="flex">
      <div class="w-1/2 hidden lg:block">
        <img
          src={~p"/images/section-invoice.png"}
          alt="EasyBills Image"
          class="object-cover w-full h-full"
        />
      </div>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
