defmodule BlogWeb.ShoppingListLive.Index do
  use BlogWeb, :live_view

  alias Blog.ShoppingLists
  alias Blog.ShoppingLists.ShoppingList

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :shopping_lists, list_shopping_lists())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Shopping list")
    |> assign(:shopping_list, ShoppingLists.get_shopping_list!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Shopping list")
    |> assign(:shopping_list, %ShoppingList{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Shopping lists")
    |> assign(:shopping_list, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    shopping_list = ShoppingLists.get_shopping_list!(id)
    {:ok, _} = ShoppingLists.delete_shopping_list(shopping_list)

    {:noreply, assign(socket, :shopping_lists, list_shopping_lists())}
  end

  defp list_shopping_lists do
    ShoppingLists.list_shopping_lists()
  end
end
