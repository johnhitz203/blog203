defmodule Blog.Recipes do
  @moduledoc """
  The Recipes context.
  """

  import Ecto.Query, warn: false
  alias Blog.Repo

  alias Blog.Recipes.Recipe

  @doc """
  Returns the list of recipes.

  ## Examples

      iex> list_recipes()
      [%Recipe{}, ...]

  """
  def list_recipes do
    Repo.all(Recipe)
  end

  @doc """
  Gets a single recipe.

  Raises `Ecto.NoResultsError` if the Recipe does not exist.

  ## Examples

      iex> get_recipe!(123)
      %Recipe{}

      iex> get_recipe!(456)
      ** (Ecto.NoResultsError)

  """
  def get_recipe!(id), do: Repo.get!(Recipe, id)

  @doc """
  Creates a recipe.

  ## Examples

      iex> create_recipe(%{field: value})
      {:ok, %Recipe{}}

      iex> create_recipe(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_recipe(attrs \\ %{}) do
    %Recipe{}
    |> Recipe.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a recipe.

  ## Examples

      iex> update_recipe(recipe, %{field: new_value})
      {:ok, %Recipe{}}

      iex> update_recipe(recipe, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_recipe(%Recipe{} = recipe, attrs) do
    recipe
    |> Recipe.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a recipe.

  ## Examples

      iex> delete_recipe(recipe)
      {:ok, %Recipe{}}

      iex> delete_recipe(recipe)
      {:error, %Ecto.Changeset{}}

  """
  def delete_recipe(%Recipe{} = recipe) do
    Repo.delete(recipe)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking recipe changes.

  ## Examples

      iex> change_recipe(recipe)
      %Ecto.Changeset{data: %Recipe{}}

  """
  def change_recipe(%Recipe{} = recipe, attrs \\ %{}) do
    Recipe.changeset(recipe, attrs)
  end

  alias Blog.Recipes.RecipeItem

  @doc """
  Returns the list of recipe_items.

  ## Examples

      iex> list_recipe_items()
      [%RecipeItem{}, ...]

  """
  def list_recipe_items do
    Repo.all(RecipeItem)
  end

  @doc """
  Gets a single recipe_item.

  Raises `Ecto.NoResultsError` if the Recipe item does not exist.

  ## Examples

      iex> get_recipe_item!(123)
      %RecipeItem{}

      iex> get_recipe_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_recipe_item!(id), do: Repo.get!(RecipeItem, id)

  @doc """
  Creates a recipe_item.

  ## Examples

      iex> create_recipe_item(%{field: value})
      {:ok, %RecipeItem{}}

      iex> create_recipe_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_recipe_item(attrs \\ %{}) do
    %RecipeItem{}
    |> RecipeItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a recipe_item.

  ## Examples

      iex> update_recipe_item(recipe_item, %{field: new_value})
      {:ok, %RecipeItem{}}

      iex> update_recipe_item(recipe_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_recipe_item(%RecipeItem{} = recipe_item, attrs) do
    recipe_item
    |> RecipeItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a recipe_item.

  ## Examples

      iex> delete_recipe_item(recipe_item)
      {:ok, %RecipeItem{}}

      iex> delete_recipe_item(recipe_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_recipe_item(%RecipeItem{} = recipe_item) do
    Repo.delete(recipe_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking recipe_item changes.

  ## Examples

      iex> change_recipe_item(recipe_item)
      %Ecto.Changeset{data: %RecipeItem{}}

  """
  def change_recipe_item(%RecipeItem{} = recipe_item, attrs \\ %{}) do
    RecipeItem.changeset(recipe_item, attrs)
  end
end
