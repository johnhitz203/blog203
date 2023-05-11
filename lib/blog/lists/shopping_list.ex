defmodule Blog.Lists.ShoppingList do
  use Ecto.Schema
  import Ecto.Changeset

  alias Blog.Lists.ShoppingList

  schema "shopping_lists" do
    field :list_name, :string
    # field :active, :utc_datetime
    has_many :shopping_list_items, Blog.Lists.ShoppingListItems

    timestamps()
  end

  @doc false
  def changeset(shopping_list, attrs) do
    shopping_list
    |> cast(attrs, [:list_name])
    |> validate_required([:list_name])
  end

  def changeset_with_items(shopping_list, attrs) do
    shopping_list
    |> cast(attrs, [])
    |> cast_assoc(:shopping_list_items, with: ShoppingList.changeset())
  end
end
