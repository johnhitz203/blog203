defmodule Blog.ShoppingListsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Blog.ShoppingLists` context.
  """

  @doc """
  Generate a shopping_list.
  """
  def shopping_list_fixture(attrs \\ %{}) do
    {:ok, shopping_list} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Blog.ShoppingLists.create_shopping_list()

    shopping_list
  end
end
