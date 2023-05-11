defmodule BlogWeb.ShoppingListLive.ItemForm do
  use BlogWeb, :live_component

  alias Phoenix.Socket
  alias Blog.Lists.ShoppingListItems
  alias Blog.Lists

  # def mount(_params, _session, socket) do
  #   IO.inspect(Map.keys(socket, label: "item_form mount"))

  #   {
  #     :ok,
  #     socket
  #   }
  # end

  def update(assigns, socket) do
    item = socket.assigns[:item]

    socket =
      socket
      |> assign(
        :changeset,
        ShoppingListItems.changeset(
          item || %ShoppingListItems{},
          %{}
        )
      )
      |> assign(:some_value, "This is valuable")
      |> assign(:shopping_list_id, assigns.shopping_list_id)

    {
      :ok,
      socket
    }
  end

  def render(assigns) do
    ~H"""
    <div class="mx-20 my-20">
      <.form class="flex"
        let={f}
        for={@changeset}
        id="item_form"
        phx-target={@myself}
        phx-submit="add_item">

        <div class="flex flex-col m-1">
        <%= label f, :item %>
        <%= text_input f, :item %>
        <%= error_tag f, :item %>
        </div>

        <div class="flex flex-col m-1 w-16">
        <%= label f, :quantity %>
        <%= text_input f, :quantity %>
        <%= error_tag f, :quantity %>
        </div>

        <div class="flex flex-col m-1 w-24">
        <%= label f, :unit %>
        <%= text_input f, :unit %>
        <%= error_tag f, :unit %>
        </div>

        <%= if assigns[:item] do %>
          <div class="flex items-center">
          <%= submit "update item", phx_disable_with: "Saving..." %>
          </div>
        <% else %>
          <%= submit "add item", phx_disable_with: "Saving..." %>
        <% end %>
      </.form>
    </div>
    """
  end

  def handle_event("add_item", params, socket) do
    params =
      Map.put(params["shopping_list_items"], "shopping_list_id", socket.assigns.shopping_list_id)

    case Lists.create_shopping_list_items(params) do
      {:ok, shopping_list_item} ->
        IO.inspect(shopping_list_item.shopping_list_id,
          label: "shopping_list_item in item_form line 86"
        )

        send(self(), {"list_item_created", shopping_list_item.shopping_list_id})

        {
          :noreply,
          socket
          |> put_flash(:info, "#{shopping_list_item.item} successfully inserted!")
        }

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
