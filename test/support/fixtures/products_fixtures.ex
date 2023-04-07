defmodule Blog.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Blog.Products` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Blog.Products.create_product()

    product
  end
end
