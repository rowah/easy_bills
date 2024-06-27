defmodule EasyBillsWeb.InvoiceLive.Show do
  use EasyBillsWeb, :live_view

  alias EasyBills.Billing

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:invoice, Billing.get_invoice!(id))}
  end

  defp page_title(:show), do: "Show Invoice"
  defp page_title(:edit), do: "Edit Invoice"

  defp transform_id(id) do
    # ("#" <> id)
    id
    |> String.upcase()
    |> String.slice(0, 6)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    invoice = Billing.get_invoice!(id)
    # TODO: handle result
    {:ok, _} = Billing.delete_invoice(invoice)

    {:noreply,
     socket
     |> stream_delete(:invoices, invoice)
     |> push_patch(to: ~p"/invoices")}
  end

  @impl true
  def handle_event("edit", %{"id" => id}, socket) do
    {:noreply, push_navigate(socket, to: ~p"/invoices/#{id}/edit")}
  end

  # @impl true
  # def handle_event("mark_as_paid", %{"id" => id}, socket) do
  #   invoice = Billing.get_invoice!(id)
  #   # TODO: handle result
  #   {:ok, _} = Billing.mark_as_paid(invoice)

  #   {:noreply, socket}
  # end

  # @impl true
  # def handle_event("mark_as_unpaid", %{"id" => id}, socket) do
  #   invoice = Billing.get_invoice!(id)
  #   # TODO: handle result
  #   {:ok, _} = Billing.mark_as_unpaid(invoice)

  #   {:noreply, socket}
  # end
end
