defmodule BlogWeb.RecipeLive.IngredientForm do
  use BlogWeb, :live_component
  alias Blog.Recipes.RecipeItem
  alias Blog.Recipes

  def update(assigns, socket) do
    {
      :ok,
      socket
      |> assign(assigns)
      |> assign_changeset()
      # |> assign(search_results: [])
      # |> assign(search: "")
    }
  end

  defp assign_changeset(%{assigns: %{recipe_id: recipe_id}} = socket) do
    item = socket.assigns[:item]

    assign(
      socket,
      :changeset,
      RecipeItem.changeset(item || %RecipeItem{recipe_id: recipe_id}, %{})
    )
  end

  def render(assigns) do
    ~H"""
    <div>
      <.form class="flex"
        let={f}
        for={@changeset}
        id="ingredient-form"
        phx-target={@myself}
        :phx-change="validate"
        :phx-submit="save"

        phx-submit="add_ingredient">


        <div class="flex flex-col m-1">
        <%= label f, :ingredient %>
        <%= text_input f, :ingredient %>
        <%= error_tag f, :ingredient %>
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
          <%= submit "update ingredient", phx_disable_with: "Saving..." %>
          </div>
        <% else %>
          <%= submit "add ingredient", phx_disable_with: "Saving..." %>
        <% end %>
      </.form>
      <a href="/recipes" class="mx-3 text-stone-200 hover:text-white transition duration-300 ease-in-out">Save</a>
    </div>
    """
  end

  # def handle_event("save", params, socket) do
  #   IO.inspect(socket.assigns.recipe, label: "assigns ingredient_form 59")

  #   # recipe_id =
  #   #   socket.assigns.recipe.id
  #   #   |> IO.inspect(label: "line 63 ingredient form")

  #   Recipes.create_recipe_item(params)
  #   {:noreply, socket}
  # end

  def handle_event("add_ingredient", params, socket) do
    params = Map.put(params["recipe_item"], "recipe_id", socket.assigns.recipe_id)

    case Recipes.create_recipe_item(params) do
      {:ok, recipe_item} ->
        send(self(), {"recipe_item_created", recipe_item.recipe_id})

        {
          :noreply,
          socket
          |> put_flash(:info, "#{recipe_item.ingredient} successfully inserted!")
        }

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
