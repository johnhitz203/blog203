defmodule Blog.Repo.Migrations.CreateShoppingLists do
  use Ecto.Migration

  def change do
    create table(:shopping_lists) do
      add :name, :string

      timestamps()
    end
  end
end
