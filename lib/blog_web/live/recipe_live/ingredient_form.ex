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
      |> assign_recipe_item()
      |> assign_changeset()
    }
  end

  defp assign_recipe(%{assigns: %{recipe: recipe}} = socket) do
    assign(socket, :recipe_id, %RecipeItem{recipe_id: recipe.id})
  end

  defp assign_id(socket) do
    id = socket.assigns[:id]
  end

  defp assign_recipe_item(socket) do
    item = socket.assigns[:item]

    assign(socket, :item, item || nil)
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
      <div >
      <%= if @recipe.recipe_items !== [] do %>
        <h1><%#= @name %></h1>
        <%= inspect(@id) %>
      <% end %>

      <%#= inspect(@item.ingredient) %>
      <%!-- <h2>Ingredients</h2> --%>

      <.form
        let={f}
        for={@changeset}
        id="ingredient-form"
        phx-target={@myself}

        phx-submit="add_ingredient">
        <!--phx-click="validate"-->
        <!--phx-submit="save"-->



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

        <%= if @item != nil do %>
          <%= submit "update ingredient", phx_disable_with: "Saving..." %>
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
    case Recipes.create_recipe_item(params["recipe_item"]) do
      {:ok, recipe_item} ->
        IO.inspect(recipe_item, label: "Recipe item ingredient form line: 100")

        {
          :noreply,
          socket
          |> put_flash(:info, "#{recipe_item.ingredient} successfully inserted!")
          |> push_redirect(to: "/recipes/#{recipe_item.recipe_id}/edit")

          # |> push_patch(to: "/recipes/#{recipe_item.recipe_id}/edit")
        }

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  # %{"_target" => ["recipe_item", "ingredient"], "recipe_item" => %{"ingredient" => "d", "quantity" => "", "recipe_i" => "", "units" => ""}}

  # def handle_event("validate", %{"recipe" => } , socket) do
  #   IO.puts("validate")
  #   {:noreply, socket}
  # end

  # def handle_event("validate", %{"recipe_item" => recipe_params}, socket) do
  #   changeset =
  #     socket.assigns.recipe_item
  #     |> Recipes.change_recipe(recipe_params)
  #     |> Map.put(:action, :validate)

  #   {:noreply, assign(socket, :changeset, changeset)}
  # end
end
