defmodule Blog.RecipesTest do
  use Blog.DataCase

  alias Blog.Recipes.RecipeItem
  alias Blog.Recipes

  describe "recipes" do
    alias Blog.Recipes.Recipe

    import Blog.RecipesFixtures

    @invalid_attrs %{name: nil}

    test "list_recipes/0 returns all recipes" do
      recipe = recipe_fixture()
      assert Recipes.list_recipes() == [recipe]
    end

    test "get_recipe!/1 returns the recipe with given id w/ it's associated recipe_items" do
      recipe1 = recipe_fixture()
      recipe_item1 = recipe_item_fixture(recipe_id: recipe1.id)
      recipe_item2 = recipe_item_fixture(recipe_id: recipe1.id)

      assert Recipes.get_recipe!(recipe1.id).recipe_item == [recipe_item1, recipe_item2]
    end

    test "create_recipe/1 with valid data creates a recipe" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Recipe{} = recipe} = Recipes.create_recipe(valid_attrs)
      assert recipe.name == "some name"
    end

    test "create_recipe/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipes.create_recipe(@invalid_attrs)
    end

    test "update_recipe/2 with valid data updates the recipe" do
      recipe = recipe_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Recipe{} = recipe} = Recipes.update_recipe(recipe, update_attrs)
      assert recipe.name == "some updated name"
    end

    test "update_recipe/2 with invalid data returns error changeset" do
      recipe = recipe_fixture()
      assert {:error, %Ecto.Changeset{}} = Recipes.update_recipe(recipe, @invalid_attrs)

      assert recipe.name == Recipes.get_recipe!(recipe.id).name
    end

    test "delete_recipe/1 deletes the recipe" do
      recipe = recipe_fixture()
      assert {:ok, %Recipe{}} = Recipes.delete_recipe(recipe)
      assert_raise Ecto.NoResultsError, fn -> Recipes.get_recipe!(recipe.id) end
    end

    test "change_recipe/1 returns a recipe changeset" do
      recipe = recipe_fixture()
      assert %Ecto.Changeset{} = Recipes.change_recipe(recipe)
    end
  end

  describe "recipe_items" do
    alias Blog.Recipes.RecipeItem

    import Blog.RecipesFixtures

    @invalid_attrs %{ingredient: nil, quantity: nil, unit: nil}

    test "list_recipe_items/0 returns all recipe_items" do
      recipe = recipe_fixture()
      recipe_item = recipe_item_fixture(recipe_id: recipe.id)
      assert Recipes.list_recipe_items() == [recipe_item]
    end

    test "get_recipe_item!/1 returns the recipe_item with given id" do
      recipe = recipe_fixture()
      recipe_item = recipe_item_fixture(recipe_id: recipe.id)
      assert Recipes.get_recipe_item!(recipe_item.id) == recipe_item
    end

    test "create_recipe_item/1 with valid data creates a recipe_item" do
      recipe = recipe_fixture()

      valid_attrs = %{
        ingredient: "some ingredient",
        quantity: 42,
        unit: "some unit",
        recipe_id: recipe.id
      }

      assert {:ok, %RecipeItem{} = recipe_item} = Recipes.create_recipe_item(valid_attrs)
      assert recipe_item.ingredient == "some ingredient"
      assert recipe_item.quantity == 42
      assert recipe_item.unit == "some unit"
    end

    test "create_recipe_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipes.create_recipe_item(@invalid_attrs)
    end

    test "update_recipe_item/2 with valid data updates the recipe_item" do
      recipe = recipe_fixture()
      recipe_item = recipe_item_fixture(recipe_id: recipe.id)

      update_attrs = %{
        ingredient: "some updated ingredient",
        quantity: 43,
        unit: "some updated unit"
      }

      assert {:ok, %RecipeItem{} = recipe_item} =
               Recipes.update_recipe_item(recipe_item, update_attrs)

      assert recipe_item.ingredient == "some updated ingredient"
      assert recipe_item.quantity == 43
      assert recipe_item.unit == "some updated unit"
    end

    test "update_recipe_item/2 with invalid data returns error changeset" do
      recipe = recipe_fixture()
      recipe_item = recipe_item_fixture(recipe_id: recipe.id)
      assert {:error, %Ecto.Changeset{}} = Recipes.update_recipe_item(recipe_item, @invalid_attrs)
      assert recipe_item == Recipes.get_recipe_item!(recipe_item.id)
    end

    test "delete_recipe_item/1 deletes the recipe_item" do
      recipe = recipe_fixture()
      recipe_item = recipe_item_fixture(recipe_id: recipe.id)
      assert {:ok, %RecipeItem{}} = Recipes.delete_recipe_item(recipe_item)
      assert_raise Ecto.NoResultsError, fn -> Recipes.get_recipe_item!(recipe_item.id) end
    end

    test "change_recipe_item/1 returns a recipe_item changeset" do
      recipe = recipe_fixture()
      recipe_item = recipe_item_fixture(recipe_id: recipe.id)

      assert %Ecto.Changeset{} = Recipes.change_recipe_item(recipe_item)
    end
  end
end
