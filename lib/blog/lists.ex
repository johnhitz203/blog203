defmodule Blog.Lists do
  @moduledoc """
  The Lists context.
  """

  import Ecto.Query, warn: false
  alias Blog.Repo

  alias Blog.Lists.ShoppingList

  @doc """
  Returns the list of shopping_lists.

  ## Examples

      iex> list_shopping_lists()
      [%ShoppingList{}, ...]

  """
  def list_shopping_lists do
    Repo.all(ShoppingList)
  end

  @doc """
  Gets a single shopping_list.

  Raises `Ecto.NoResultsError` if the Shopping list does not exist.

  ## Examples

      iex> get_shopping_list!(123)
      %ShoppingList{}

      iex> get_shopping_list!(456)
      ** (Ecto.NoResultsError)

  """
  def get_shopping_list!(id), do: Repo.get!(ShoppingList, id)

  @doc """
  Creates a shopping_list.

  ## Examples

      iex> create_shopping_list(%{field: value})
      {:ok, %ShoppingList{}}

      iex> create_shopping_list(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_shopping_list(attrs \\ %{}) do
    %ShoppingList{}
    |> ShoppingList.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a shopping_list.

  ## Examples

      iex> update_shopping_list(shopping_list, %{field: new_value})
      {:ok, %ShoppingList{}}

      iex> update_shopping_list(shopping_list, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_shopping_list(%ShoppingList{} = shopping_list, attrs) do
    shopping_list
    |> ShoppingList.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a shopping_list.

  ## Examples

      iex> delete_shopping_list(shopping_list)
      {:ok, %ShoppingList{}}

      iex> delete_shopping_list(shopping_list)
      {:error, %Ecto.Changeset{}}

  """
  def delete_shopping_list(%ShoppingList{} = shopping_list) do
    Repo.delete(shopping_list)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking shopping_list changes.

  ## Examples

      iex> change_shopping_list(shopping_list)
      %Ecto.Changeset{data: %ShoppingList{}}

  """
  def change_shopping_list(%ShoppingList{} = shopping_list, attrs \\ %{}) do
    ShoppingList.changeset(shopping_list, attrs)
  end
end
