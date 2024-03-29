defmodule BlogWeb.ShoppingListLive.Show do
  use BlogWeb, :live_view

  alias Blog.Lists
  alias BlogWeb.ShoppingListLive.ItemForm

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      # id of shopping list to optimize
      BlogWeb.Endpoint.subscribe("shopping_list_items")
    end

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:shopping_list, Lists.get_shopping_list!(id))}
  end

  @impl true
  def handle_info(%{topic: "shopping_list_items", payload: _payload}, socket) do
    {
      :noreply,
      socket
      |> assign(:shopping_list, Lists.get_shopping_list!(socket.assigns.shopping_list.id))
    }
  end

  def handle_info({"list_item_created", id}, socket) do
    {
      :noreply,
      socket
      # |> assign(:shopping_lists, list_shopping_lists())
      |> assign(:shopping_list, Lists.get_shopping_list!(id))
    }
  end

  defp page_title(:show), do: "Show Shopping list"
  defp page_title(:edit), do: "Edit Shopping list"
end
