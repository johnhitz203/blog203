defmodule Blog.Recipes.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recipes" do
    field :name, :string
    has_many :recipe_items, Blog.Recipes.RecipeItem

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def changeset_with_items(recipe, attrs) do
    recipe
    |> cast(attrs, [])
    |> cast_assoc(:recipe_items, with: RecipeItem.changeset())
  end
end
