defmodule Blog.Recipes.RecipeItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recipe_items" do
    field :ingredient, :string
    field :quantity, :integer
    field :unit, :string
    belongs_to(:recipe, Blog.Recipes.Recipe)
    belongs_to(:product, Blog.Products.Product)

    timestamps()
  end

  @doc false
  def changeset(recipe_item, attrs) do
    recipe_item
    |> cast(attrs, [:ingredient, :unit, :quantity, :recipe_id])
    |> validate_required([:ingredient, :unit, :quantity, :recipe_id])
  end
end
