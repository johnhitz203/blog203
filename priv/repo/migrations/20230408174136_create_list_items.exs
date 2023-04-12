defmodule Blog.Repo.Migrations.CreateListItems do
  use Ecto.Migration

  def change do
    create table(:list_items) do
      add :quantity, :integer
      add :unit, :string
      add :custom_name, :string
      add :shopping_list_id, references(:shopping_lists, on_delete: :nothing)
      add :product_id, references(:products, on_delete: :nothing)

      timestamps()
    end

    create index(:list_items, [:shopping_list_id])
  end
end
