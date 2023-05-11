defmodule BlogWeb.ShoppingListLive.Index do
  use BlogWeb, :live_view

  alias Blog.Lists
  alias Blog.Lists.ShoppingList

  @impl true
  def mount(_params, session, socket) do
    user = Blog.Accounts.get_user_by_session_token(session["user_token"])

    {
      :ok,
      socket
      |> assign(:shopping_lists, list_shopping_lists())
      |> assign(:current_user, user)
      |> assign(:active_list_id, user.active_shopping_list_id)
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Shopping list")
    |> assign(:shopping_list, Lists.get_shopping_list!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Shopping list")
    |> assign(:shopping_list, %ShoppingList{shopping_list_items: []})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Shopping lists")
    |> assign(:shopping_list, nil)
  end

  @impl true
  def handle_event("make_active", %{"list_id" => list_id} = params, socket) do
    {:ok, active_list_id} = Blog.Accounts.update_active_list(socket.assigns.current_user, list_id)
    socket = assign(socket, :active_list_id, active_list_id)
    IO.inspect(socket.assigns.active_list_id, label: "my list")

    {
      :noreply,
      socket
    }
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    shopping_list = Lists.get_shopping_list!(id)
    {:ok, _} = Lists.delete_shopping_list(shopping_list)

    {:noreply, assign(socket, :shopping_lists, list_shopping_lists())}
  end

  @impl true
  def handle_info({"list_item_created", id}, socket) do
    {
      :noreply,
      socket
      # |> assign(:shopping_lists, list_shopping_lists())
      |> assign(:shopping_list, Lists.get_shopping_list!(id))
    }
  end

  defp list_shopping_lists do
    Lists.list_shopping_lists()
  end
end
