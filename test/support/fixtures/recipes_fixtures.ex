defmodule Blog.RecipesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Blog.Recipes` context.
  """

  @doc """
  Generate a recipe.
  """
  def recipe_fixture(attrs \\ %{}) do
    {:ok, recipe} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Blog.Recipes.create_recipe()

    recipe
  end

  @doc """
  Generate a recipe_item.
  """
  def recipe_item_fixture(attrs \\ %{}) do
    {:ok, recipe_item} =
      attrs
      |> Enum.into(%{
        ingredient: "some ingredient",
        quantity: 42,
        unit: "some unit"
      })
      |> Blog.Recipes.create_recipe_item()

    recipe_item
  end
end
