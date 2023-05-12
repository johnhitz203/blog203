defmodule Blog.Repo.Migrations.MakeShoppingListActive do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :active_shopping_list_id, references(:shopping_lists, on_delete: :nothing)
    end
  end
end
