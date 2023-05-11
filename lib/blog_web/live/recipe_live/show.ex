defmodule BlogWeb.RecipeLive.Show do
  use BlogWeb, :live_view

  alias Blog.Recipes
  alias Blog.Lists
  alias BlogWeb.RecipeLive.IngredientForm

  @impl true
  def mount(_params, session, socket) do
    user = Blog.Accounts.get_user_by_session_token(session["user_token"])

    {
      :ok,
      socket
      |> assign(rerender?: false)
      |> assign(current_user: user)
    }
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {
      :noreply,
      socket
      |> assign(:page_title, page_title(socket.assigns.live_action))
      |> assign(:recipe, Recipes.get_recipe!(id))
    }
  end

  @impl true
  def handle_event("add_to_list", attrs, socket) do
    BlogWeb.Endpoint.broadcast("shopping_list_items", "add_to_list", %{})

    attrs =
      Map.put(attrs, "shopping_list_id", socket.assigns.current_user.active_shopping_list_id)

    Lists.create_shopping_list_items(attrs)
    |> IO.inspect(label: "line 34")

    {:noreply, socket}
  end

  @impl true
  def handle_info({"recipe_item_created", id}, socket) do
    {
      :noreply,
      socket
      |> assign(:recipe, Recipes.get_recipe!(id))
    }
  end

  defp page_title(:show), do: "Show Recipe"
  defp page_title(:edit), do: "Edit Recipe"
end
