defmodule BlogWeb.ShoppingListLive.FormComponent do
  use BlogWeb, :live_component

  alias Blog.Lists

  @impl true
  def update(%{shopping_list: shopping_list} = assigns, socket) do
    changeset = Lists.change_shopping_list(shopping_list)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"shopping_list" => shopping_list_params}, socket) do
    changeset =
      socket.assigns.shopping_list
      |> Lists.change_shopping_list(shopping_list_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"shopping_list" => shopping_list_params}, socket) do
    save_shopping_list(socket, socket.assigns.action, shopping_list_params)
  end

  defp save_shopping_list(socket, :edit, shopping_list_params) do
    case Lists.update_shopping_list(socket.assigns.shopping_list, shopping_list_params) do
      {:ok, _shopping_list} ->
        {:noreply,
         socket
         |> put_flash(:info, "Shopping list updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_shopping_list(socket, :new, shopping_list_params) do
    case Lists.create_shopping_list(shopping_list_params) do
      {:ok, _shopping_list} ->
        {:noreply,
         socket
         |> put_flash(:info, "Shopping list created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
