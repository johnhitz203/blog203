defmodule Blog.Repo.Migrations.CreateShoppingListItems do
  use Ecto.Migration

  def change do
    create table(:shopping_list_items) do
      add :item, :string
      add :quantity, :integer
      add :unit, :string
      add :shopping_list_id, references(:shopping_lists, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:shopping_list_items, [:shopping_list_id])
  end
end
