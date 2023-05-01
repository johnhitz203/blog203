defmodule BlogWeb.ShoppingListLiveTest do
  use BlogWeb.ConnCase

  import Phoenix.LiveViewTest
  import Blog.ListsFixtures

  @create_attrs %{list_name: "some list_name"}
  @update_attrs %{list_name: "some updated list_name"}
  @invalid_attrs %{list_name: nil}

  defp create_shopping_list(_) do
    shopping_list = shopping_list_fixture()
    %{shopping_list: shopping_list}
  end

  describe "Index" do
    setup [:create_shopping_list]

    test "lists all shopping_lists", %{conn: conn, shopping_list: shopping_list} do
      {:ok, _index_live, html} = live(conn, Routes.shopping_list_index_path(conn, :index))

      assert html =~ "Listing Shopping lists"
      assert html =~ shopping_list.list_name
    end

    test "saves new shopping_list", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.shopping_list_index_path(conn, :index))

      assert index_live |> element("a", "New Shopping list") |> render_click() =~
               "New Shopping list"

      assert_patch(index_live, Routes.shopping_list_index_path(conn, :new))

      assert index_live
             |> form("#shopping_list-form", shopping_list: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#shopping_list-form", shopping_list: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.shopping_list_index_path(conn, :index))

      assert html =~ "Shopping list created successfully"
      assert html =~ "some list_name"
    end

    test "updates shopping_list in listing", %{conn: conn, shopping_list: shopping_list} do
      {:ok, index_live, _html} = live(conn, Routes.shopping_list_index_path(conn, :index))

      assert index_live |> element("#shopping_list-#{shopping_list.id} a", "Edit") |> render_click() =~
               "Edit Shopping list"

      assert_patch(index_live, Routes.shopping_list_index_path(conn, :edit, shopping_list))

      assert index_live
             |> form("#shopping_list-form", shopping_list: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#shopping_list-form", shopping_list: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.shopping_list_index_path(conn, :index))

      assert html =~ "Shopping list updated successfully"
      assert html =~ "some updated list_name"
    end

    test "deletes shopping_list in listing", %{conn: conn, shopping_list: shopping_list} do
      {:ok, index_live, _html} = live(conn, Routes.shopping_list_index_path(conn, :index))

      assert index_live |> element("#shopping_list-#{shopping_list.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#shopping_list-#{shopping_list.id}")
    end
  end

  describe "Show" do
    setup [:create_shopping_list]

    test "displays shopping_list", %{conn: conn, shopping_list: shopping_list} do
      {:ok, _show_live, html} = live(conn, Routes.shopping_list_show_path(conn, :show, shopping_list))

      assert html =~ "Show Shopping list"
      assert html =~ shopping_list.list_name
    end

    test "updates shopping_list within modal", %{conn: conn, shopping_list: shopping_list} do
      {:ok, show_live, _html} = live(conn, Routes.shopping_list_show_path(conn, :show, shopping_list))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Shopping list"

      assert_patch(show_live, Routes.shopping_list_show_path(conn, :edit, shopping_list))

      assert show_live
             |> form("#shopping_list-form", shopping_list: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#shopping_list-form", shopping_list: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.shopping_list_show_path(conn, :show, shopping_list))

      assert html =~ "Shopping list updated successfully"
      assert html =~ "some updated list_name"
    end
  end
end
