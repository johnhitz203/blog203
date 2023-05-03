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
      valid_attrs = %{list_name: "some list_name"}

      assert {:ok, %ShoppingList{} = shopping_list} = Lists.create_shopping_list(valid_attrs)
      assert shopping_list.list_name == "some list_name"
    end

    test "create_shopping_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lists.create_shopping_list(@invalid_attrs)
    end

    test "update_shopping_list/2 with valid data updates the shopping_list" do
      shopping_list = shopping_list_fixture()
      update_attrs = %{list_name: "some updated list_name"}

      assert {:ok, %ShoppingList{} = shopping_list} = Lists.update_shopping_list(shopping_list, update_attrs)
      assert shopping_list.list_name == "some updated list_name"
    end

    test "update_shopping_list/2 with invalid data returns error changeset" do
      shopping_list = shopping_list_fixture()
      assert {:error, %Ecto.Changeset{}} = Lists.update_shopping_list(shopping_list, @invalid_attrs)
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
end
