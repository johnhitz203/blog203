defmodule BlogWeb.RecipeLive.Show do
  use BlogWeb, :live_view

  alias Blog.Recipes
  alias BlogWeb.RecipeLive.IngredientForm

  @impl true
  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign(rerender?: false)
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
