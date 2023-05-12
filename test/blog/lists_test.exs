defmodule Blog.ListsTest do
  use Blog.DataCase

  alias Blog.Lists

  describe "shopping_lists" do
    alias Blog.Lists.ShoppingList

    import Blog.ListsFixtures

    @invalid_attrs %{list_name: nil}

    test "list_shopping_lists/0 returns all shopping_lists" do
      shopping_list = shopping_list_fixture()
      assert Lists.list_shopping_lists() == [shopping_list]
    end

    test "get_shopping_list!/1 returns the shopping_list with given id" do
      shopping_list = shopping_list_fixture()
      assert Lists.get_shopping_list!(shopping_list.id) == shopping_list
    end

    test "create_shopping_list/1 with valid data creates a shopping_list" do
      now = DateTime.utc_now()
      valid_attrs = %{list_name: "some list_name", active: now}

      assert {:ok, %ShoppingList{} = shopping_list} = Lists.create_shopping_list(valid_attrs)
      assert DateTime.to_unix(shopping_list.active) == DateTime.to_unix(now)
      assert shopping_list.list_name == "some list_name"
    end

    test "create_shopping_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lists.create_shopping_list(@invalid_attrs)
    end

    test "update_shopping_list/2 with valid data updates the shopping_list" do
      shopping_list = shopping_list_fixture()
      update_attrs = %{list_name: "some updated list_name"}

      assert {:ok, %ShoppingList{} = shopping_list} =
               Lists.update_shopping_list(shopping_list, update_attrs)

      assert shopping_list.list_name == "some updated list_name"
    end

    test "update_shopping_list/2 with invalid data returns error changeset" do
      shopping_list = shopping_list_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Lists.update_shopping_list(shopping_list, @invalid_attrs)

      assert shopping_list == Lists.get_shopping_list!(shopping_list.id)
    end

    test "delete_shopping_list/1 deletes the shopping_list" do
      shopping_list = shopping_list_fixture()
      assert {:ok, %ShoppingList{}} = Lists.delete_shopping_list(shopping_list)
      assert_raise Ecto.NoResultsError, fn -> Lists.get_shopping_list!(shopping_list.id) end
    end

    test "change_shopping_list/1 returns a shopping_list changeset" do
      shopping_list = shopping_list_fixture()
      assert %Ecto.Changeset{} = Lists.change_shopping_list(shopping_list)
    end
  end

  describe "shopping_list_items" do
    alias Blog.Lists.ShoppingListItems

    import Blog.ListsFixtures

    @invalid_attrs %{item: nil, quantity: nil, unit: nil}

    test "list_shopping_list_items/0 returns all shopping_list_items" do
      shopping_list_items = shopping_list_items_fixture()
      assert Lists.list_shopping_list_items() == [shopping_list_items]
    end

    test "get_shopping_list_items!/1 returns the shopping_list_items with given id" do
      shopping_list_items = shopping_list_items_fixture()
      assert Lists.get_shopping_list_items!(shopping_list_items.id) == shopping_list_items
    end

    test "create_shopping_list_items/1 with valid data creates a shopping_list_items" do
      valid_attrs = %{item: "some item", quantity: 42, unit: "some unit"}

      assert {:ok, %ShoppingListItems{} = shopping_list_items} =
               Lists.create_shopping_list_items(valid_attrs)

      assert shopping_list_items.item == "some item"
      assert shopping_list_items.quantity == 42
      assert shopping_list_items.unit == "some unit"
    end

    test "create_shopping_list_items/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lists.create_shopping_list_items(@invalid_attrs)
    end

    test "update_shopping_list_items/2 with valid data updates the shopping_list_items" do
      shopping_list_items = shopping_list_items_fixture()
      update_attrs = %{item: "some updated item", quantity: 43, unit: "some updated unit"}

      assert {:ok, %ShoppingListItems{} = shopping_list_items} =
               Lists.update_shopping_list_items(shopping_list_items, update_attrs)

      assert shopping_list_items.item == "some updated item"
      assert shopping_list_items.quantity == 43
      assert shopping_list_items.unit == "some updated unit"
    end

    test "update_shopping_list_items/2 with invalid data returns error changeset" do
      shopping_list_items = shopping_list_items_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Lists.update_shopping_list_items(shopping_list_items, @invalid_attrs)

      assert shopping_list_items == Lists.get_shopping_list_items!(shopping_list_items.id)
    end

    test "delete_shopping_list_items/1 deletes the shopping_list_items" do
      shopping_list_items = shopping_list_items_fixture()
      assert {:ok, %ShoppingListItems{}} = Lists.delete_shopping_list_items(shopping_list_items)

      assert_raise Ecto.NoResultsError, fn ->
        Lists.get_shopping_list_items!(shopping_list_items.id)
      end
    end

    test "change_shopping_list_items/1 returns a shopping_list_items changeset" do
      shopping_list_items = shopping_list_items_fixture()
      assert %Ecto.Changeset{} = Lists.change_shopping_list_items(shopping_list_items)
    end
  end
end
