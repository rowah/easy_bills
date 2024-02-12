defmodule EasyBillsWeb.UserWelcomeLive do
  @moduledoc false

  use EasyBillsWeb, :live_view

  alias EasyBills.Accounts.User
  alias EasyBillsWeb.IconsComponent
  # alias EasyBillsWeb.SimpleS3Upload

  import Phoenix.HTML.Form
  # import Phoenix.Naming

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    user = socket.assigns.current_user

    changeset =
      User.registration_changeset(user, %{})

    {:ok,
     socket
     |> assign(:changeset, changeset)
     |> assign(:uploaded_files, [])
     |> allow_upload(:avatar_url,
       accept: ~w(.jpg .jpeg .png),
       max_entries: 1
     )}
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
      <div class="md:w-[30%] mx-auto mt-16" id="avatar-image-container" phx-hook="UserAvatar">
        <div class="flex mb-14 hidden lg:block">
          <div class="flex">
            <IconsComponent.logo_icon />
            <h2 class="text-6xl font-bold ml-3 text-purple-600 mt-3">EasyBills</h2>
          </div>
        </div>
        <h3 class="font-bold text-2xl">
          Welcome! Let's create your profile.
        </h3>
        <p class="text-gray-400">Just a few more steps...</p>

        <h4 class="font-bold mt-6">Add an avatar</h4>
        <div class="w-32 h-32 rounded-full border-2 border-dashed border-gray-400">
          <img src={@current_user.avatar_url} alt="Image" class="rounded-full h-32 w-32" />
          <%= for entry <- @uploads.avatar_url.entries do %>
            <figure>
              <.live_img_preview entry={entry} class="rounded-full w-32 h-32" />
            </figure>
          <% end %>
        </div>
        <.form for={@changeset} id="upload-form" phx-change="validate" phx-submit="save">
          <.live_file_input
            upload={@uploads.avatar_url}
            id="live-file-input"
            class="invisible live-file-input"
          />
          <div id="avatar-upload-button">Choose Image</div>
          <button type="submit">upload</button>
        </.form>
      </div>

      <section phx-drop-target={@uploads.avatar_url.ref}>
        <%= for entry <- @uploads.avatar_url.entries do %>
          <%= for err <- upload_errors(@uploads.avatar_url, entry) do %>
            <p class="alert alert-danger"><%= humanize(err) %></p>
          <% end %>
        <% end %>
      </section>
    </div>
    """
  end

  @impl Phoenix.LiveView
  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  @impl Phoenix.LiveView
  def handle_event("save", _params, socket) do
    uploaded_files =
      consume_uploaded_entries(socket, :avatar_url, fn %{path: path}, _entry ->
        dest = Path.join([:code.priv_dir(:easy_bills), "static", "uploads", Path.basename(path)])
        File.cp!(path, dest)
        {:ok, ~p"/uploads/#{Path.basename(dest)}"}
      end)

    user = socket.assigns.current_user
    new_avatar_url = Enum.at(uploaded_files, 0)
    user_changeset = Ecto.Changeset.change(user, %{avatar_url: new_avatar_url})

    case EasyBills.Repo.update(user_changeset) do
      {:ok, _user} ->
        {:noreply,
         socket
         |> update(:uploaded_files, &(&1 ++ uploaded_files))}

      {:error, _changeset} ->
        {:noreply, socket}
    end

    {:noreply,
     socket
     |> update(:uploaded_files, &(&1 ++ uploaded_files))
     |> push_navigate(to: ~p"/address")}
  end
end
