defmodule EasyBillsWeb.UserAddressLive do
  use EasyBillsWeb, :live_view

  alias EasyBills.Accounts
  alias EasyBills.Accounts.User
  alias EasyBillsWeb.CoreComponents
  alias EasyBillsWeb.CommonComponents.LogoIcons

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    user = socket.assigns.current_user

    changeset = User.registration_changeset(user, %{})

    socket =
      socket
      |> assign(trigger_submit: false, check_errors: false)
      |> assign_form(changeset)

    {:ok, socket, temporary_assigns: [form: nil]}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div class="flex">
      <div class="w-1/2 h-screen hidden lg:block">
        <img
          src={~p"/images/section-invoice.png"}
          alt="EasyBills Image"
          class="object-cover w-full h-full"
        />
      </div>
      <div class="md:w-[30%] mx-auto mt-16">
        <.link
          href={~p"/welcome"}
          id="back-icon"
          class="flex text-purple-600 absolute mt-[-6%] lg:mt-[-2%] lg:ml-[-8%]"
        >
          <CoreComponents.back_icon /> <span class="mt-[-2px] ml-1">Back</span>
        </.link>
        <div class="flex mb-14 hidden lg:block">
          <div class="flex">
            <LogoIcons.logo_icon />
            <h2 class="text-6xl font-bold ml-3 text-purple-600 mt-3">EasyBills</h2>
          </div>
        </div>
        <h3 class="text-center font-bold text-2xl">
          Enter your business address details:
        </h3>
        <%!-- <img src={@current_user.avatar_url} alt="Image" /> --%>
        <.simple_form
          for={@form}
          id="address_form"
          phx-change="validate"
          phx-submit="update_address"
          phx-trigger-action={@trigger_submit}
          action={~p"/address"}
          method="post"
        >
          <.error :if={@check_errors}>
            Oops, something went wrong! Please check the errors below.
          </.error>

          <div class=" md:flex md:space-x-3">
            <div class="md:w-1/2">
              <.input
                field={@form[:country]}
                type="select"
                options={country_options()}
                label="Country"
                required
              />
            </div>
            <.input field={@form[:city]} type="text" label="City" required />
          </div>
          <.input field={@form[:street_address]} type="text" label="Street Address" required />
          <.input field={@form[:postal_code]} type="text" label="Postal Address" required />
          <.input field={@form[:phone_number]} type="tel" label="Phone Number" required />

          <div class="flex place-content-center text-lg font-semibold">
            <button
              type="submit"
              phx-disable-with="Saving..."
              class="px-8 py-1 flex items-center w-40 justify-center rounded-full text-[#FFFFFF] bg-[#7C5DFA]"
            >
              Save
            </button>
          </div>
        </.simple_form>
      </div>
    </div>
    """
  end

  def country_options do
    Enum.map(Countries.all(), & &1.name) |> Enum.sort()
  end

  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  @impl Phoenix.LiveView
  def handle_event("update_address", %{"user" => address_params}, socket) do
    user = socket.assigns.current_user

    case Accounts.update_user_address(user, address_params) do
      {:ok, _user} ->
        {:noreply,
         socket
         |> put_flash(:info, "Address updated successfully.")
         |> redirect(to: ~p"/invoices")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign(check_errors: true) |> assign_form(changeset)}
    end
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
