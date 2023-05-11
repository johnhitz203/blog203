defmodule Blog.ListsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Blog.Lists` context.
  """

  @doc """
  Generate a shopping_list.
  """
  def shopping_list_fixture(attrs \\ %{}) do
    {:ok, shopping_list} =
      attrs
      |> Enum.into(%{
        list_name: "some list_name"
      })
      |> Blog.Lists.create_shopping_list()

    shopping_list
  end

  @doc """
  Generate a shopping_list_items.
  """
  def shopping_list_items_fixture(attrs \\ %{}) do
    {:ok, shopping_list_items} =
      attrs
      |> Enum.into(%{
        item: "some item",
        quantity: 42,
        unit: "some unit"
      })
      |> Blog.Lists.create_shopping_list_items()

    shopping_list_items
  end
end
