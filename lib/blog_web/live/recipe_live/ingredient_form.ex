defmodule BlogWeb.RecipeLive.IngredientForm do
  use BlogWeb, :live_component
  alias Blog.Recipes.RecipeItem
  alias Blog.Recipes

  def update(assigns, socket) do
    IO.inspect(self(), label: "self() in ingredient_form")

    {
      :ok,
      socket
      |> assign(assigns)
      |> assign_changeset()
      |> assign(search_results: [])
      |> assign(search: "")
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
          <button class="h-12 w-12 ml-5 rounded-full bg-gray-300 hover:bg-gray-500 hover:text-gray-200 text-5xl align-middle" phx-click="add_ingredient">+</button>
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
    # send(self(), {"message", recipe_item.recipe_id})

    IO.inspect(params, label: "recipe params in add_ingredient in ingredient_form")

    case Recipes.create_recipe_item(params) do
      {:ok, recipe_item} ->
        # IO.inspect(send(self(), {"recipe_item_created", params["recipe_id"]}),
        #   label: "msg from handle_event"
        # )

        send(self(), {"recipe_item_created", recipe_item.recipe_id})

        {
          :noreply,
          socket
          |> put_flash(:info, "#{recipe_item.ingredient} successfully inserted!")
          # |> assign(:recipe, Recipes.get_recipe!(socket.assigns.recipe_id))
          # |> push_redirect(to: "/recipes/#{recipe_item.recipe_id}/edit")

          # |> push_patch(to: "/recipes/#{recipe_item.recipe_id}/edit")
        }

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  # def handle_info({msg, id}, socket) do
  #   IO.inspect(msg, label: "Catchall handle_info from ingredient_form")

  #   socket =
  #     socket
  #     |> assign(:recipes, Recipes.list_recipes())
  #     |> assign(:recipe, Recipes.get_recipe!(id))

  #   {:noreply, socket}
  # end

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

  ##############################
  # Suggestion from justin_yxx #
  ##############################
  # <.form let={f} phx-submit="edit">
  #   <%= for {i, f} <- Enum.with_index(@recipe.recipe_items), do: %>

  #     <.input f, :name, placeholder: "Name"
  #     <.input f, :quantity, placeholder: "Quantity"
  #     <.input f, :unit, placeholder: "Unit"

  #   <% end %>
  # </.form>

  # <.form let{f} for={@ingredient_changeset} phx-submit="add"/>
end
