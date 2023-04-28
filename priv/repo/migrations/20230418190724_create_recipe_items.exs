defmodule Blog.Repo.Migrations.CreateRecipeItems do
  use Ecto.Migration

  def change do
    create table(:recipe_items) do
      add :ingredient, :string
      add :unit, :string
      add :quantity, :integer
      add :recipe_id, references(:recipes, on_delete: :delete_all)
      add :product_id, references(:products, on_delete: :nothing)

      timestamps()
    end

    create index(:recipe_items, [:recipe_id])
  end
end
