defmodule Blog.Repo.Migrations.CreateShoppingLists do
  use Ecto.Migration

  def change do
    create table(:shopping_lists) do
      add :list_name, :string
      add :product_id, references(:products, on_delete: :nothing)

      timestamps()
    end

    create index(:shopping_lists, [:product_id])
  end
end
