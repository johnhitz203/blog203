defmodule BlogWeb.RecipeLive.Index do
  use BlogWeb, :live_view

  alias Blog.Recipes
  alias Blog.Recipes.Recipe

  @impl true
  def mount(_params, _session, socket) do
    IO.inspect(self(), label: "Mount pid")

    {
      :ok,
      socket
      |> assign(:recipes, list_recipes())
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :add_ingredient, %{"id" => id}) do
    socket
    |> assign(:recipe, Recipes.get_recipe!(id))
    |> assign(:page_title, "Add Ingredient")
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:recipe, Recipes.get_recipe!(id))
    |> assign(:page_title, "")
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Recipe")
    |> assign(:recipe, %Recipe{recipe_items: []})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Recipes")
    |> assign(:recipe, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    recipe = Recipes.get_recipe!(id)
    {:ok, _} = Recipes.delete_recipe(recipe)

    {:noreply, assign(socket, :recipes, list_recipes())}
  end

  # causes re-render when ingredient is added
  # Need to re-implement form
  def handle_info({msg, id}, socket) do
    IO.inspect(msg, label: "Catchall handle_info")

    socket =
      socket
      |> assign(:recipes, list_recipes())
      |> assign(:recipe, Recipes.get_recipe!(id))

    {:noreply, socket}
  end

  defp list_recipes do
    Recipes.list_recipes()
  end
end
