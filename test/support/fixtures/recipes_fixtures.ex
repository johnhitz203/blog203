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
end
