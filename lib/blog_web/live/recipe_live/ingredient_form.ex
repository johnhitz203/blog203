defmodule BlogWeb.RecipeLive.IngredientForm do
  use BlogWeb, :live_component
  alias Blog.Recipes.RecipeItem
  alias Blog.Recipes

  def update(assigns, socket) do
    {
      :ok,
      socket
      |> assign(assigns)
      |> assign_recipe()
      |> assign_changeset()
    }
  end

  defp assign_recipe(%{assigns: %{recipe: recipe}} = socket) do
    assign(socket, :recipe_id, %RecipeItem{recipe_id: recipe.id})
  end

  defp assign_changeset(%{assigns: %{recipe_id: recipe_id}} = socket) do
    assign(socket, :changeset, RecipeItem.changeset(%RecipeItem{recipe_id: recipe_id}, %{}))
  end

  def render(assigns) do
    ~H"""
    <div id="ingredient">

      <%= inspect(@recipe_id) %><br>

      <.form
        let={f}
        for={@changeset}
        id="ingredient-form"
        phx-target={@myself}
        phx-click="validate"
        phx-submit="save">

        <%= label f, :ingredient %>
        <%= text_input f, :ingredient %>
        <%= error_tag f, :ingredient %>

        <%= label f, :quantity %>
        <%= text_input f, :quantity %>
        <%= error_tag f, :quantity %>

        <%= label f, :unit %>
        <%= text_input f, :unit %>
        <%= error_tag f, :unit %>

        <%= hidden_input f, :recipe_id, value: @recipe.id %>

         <%= submit "add ingredient", phx_disable_with: "Saving..." %>
      </.form>
    </div>
    """
  end

  def handle_event("save", params, socket) do
    IO.inspect(socket.assigns.recipe, label: "assigns ingredient_form 59")

    # recipe_id =
    #   socket.assigns.recipe.id
    #   |> IO.inspect(label: "line 63 ingredient form")

    Recipes.create_recipe_item(params)
    {:noreply, socket}
  end

  # %{"_target" => ["recipe_item", "ingredient"], "recipe_item" => %{"ingredient" => "d", "quantity" => "", "recipe_i" => "", "units" => ""}}

  # def handle_event("validate", %{"recipe" => } , socket) do
  #   IO.puts("validate")
  #   {:noreply, socket}
  # end

  def handle_event("validate", params, socket) do
    IO.inspect(params, label: "params 78")
    {:noreply, socket}
  end
end
