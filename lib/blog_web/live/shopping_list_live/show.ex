defmodule BlogWeb.ShoppingListLive.Show do
  use BlogWeb, :live_view

  alias Blog.ShoppingLists

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:shopping_list, ShoppingLists.get_shopping_list!(id))}
  end

  defp page_title(:show), do: "Show Shopping list"
  defp page_title(:edit), do: "Edit Shopping list"
end
