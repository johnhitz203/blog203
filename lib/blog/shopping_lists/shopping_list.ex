defmodule Blog.ShoppingLists.ShoppingList do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shopping_lists" do
    field :name, :string
    has_many :list_items, Blog.ShoppingLists.ListItem

    timestamps()
  end

  @doc false
  def changeset(shopping_list, attrs) do
    shopping_list
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
