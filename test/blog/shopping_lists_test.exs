defmodule Blog.ShoppingListsTest do
  use Blog.DataCase

  import Blog.ShoppingListsFixtures
  import Blog.ProductsFixtures

  alias Blog.ShoppingLists.ShoppingList
  alias Blog.ShoppingLists.ListItem
  alias Blog.ShoppingLists

  describe "shopping_lists" do
    @invalid_attrs %{name: nil}

    test "list_shopping_lists/0 returns all shopping_lists" do
      shopping_list = shopping_list_fixture()
      assert ShoppingLists.list_shopping_lists() == [shopping_list]
    end

    test "get_shopping_list!/1 returns the shopping_list with given id" do
      shopping_list =
        shopping_list_fixture()
        |> Repo.preload(:list_items)

      assert ShoppingLists.get_shopping_list!(shopping_list.id) == shopping_list
    end

    test "create_shopping_list/1 with valid data creates a shopping_list" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %ShoppingList{} = shopping_list} =
               ShoppingLists.create_shopping_list(valid_attrs)

      assert shopping_list.name == "some name"
    end

    test "create_shopping_list/1 with invalid data returns error changeset" do
      IO.inspect(@invalid_attrs, label: "Invalid")
      assert {:error, %Ecto.Changeset{}} = ShoppingLists.create_shopping_list(@invalid_attrs)
    end

    test "update_shopping_list/2 with valid data updates the shopping_list" do
      shopping_list = shopping_list_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %ShoppingList{} = shopping_list} =
               ShoppingLists.update_shopping_list(shopping_list, update_attrs)

      assert shopping_list.name == "some updated name"
    end

    test "update_shopping_list/2 with invalid data returns error changeset" do
      shopping_list =
        shopping_list_fixture()
        |> Repo.preload(:list_items)

      assert {:error, %Ecto.Changeset{}} =
               ShoppingLists.update_shopping_list(shopping_list, @invalid_attrs)

      assert shopping_list == ShoppingLists.get_shopping_list!(shopping_list.id)
    end

    test "delete_shopping_list/1 deletes the shopping_list" do
      shopping_list = shopping_list_fixture()
      assert {:ok, %ShoppingList{}} = ShoppingLists.delete_shopping_list(shopping_list)

      assert_raise Ecto.NoResultsError, fn ->
        ShoppingLists.get_shopping_list!(shopping_list.id)
      end
    end

    test "change_shopping_list/1 returns a shopping_list changeset" do
      shopping_list = shopping_list_fixture()
      assert %Ecto.Changeset{} = ShoppingLists.change_shopping_list(shopping_list)
    end
  end

  describe "shopping list items" do
    test "add_list_item/1 with valid data creates a list item" do
      shopping_list = shopping_list_fixture()

      product = product_fixture()

      valid_attrs = %{
        shopping_list_id: shopping_list.id,
        product_id: product.id,
        quantity: 2,
        unit: "kg",
        custom_name: "list item name"
      }

      assert {:ok, %ListItem{} = list_item} = ShoppingLists.add_list_item(valid_attrs)
      assert list_item.shopping_list_id == shopping_list.id
      list_item_w_product = Repo.preload(list_item, :product)
      assert list_item_w_product.product == product
      shopping_list = ShoppingLists.get_shopping_list!(shopping_list.id)
      assert shopping_list.list_items == [list_item_w_product]
    end
  end
end
