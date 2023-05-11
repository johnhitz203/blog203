defmodule Blog.Lists.ShoppingListItems do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shopping_list_items" do
    field :item, :string
    field :quantity, :integer
    field :unit, :string
    belongs_to :shopping_list, Blog.Lists.List

    timestamps()
  end

  @doc false
  def changeset(shopping_list_items, attrs) do
    shopping_list_items
    |> cast(attrs, [:item, :shopping_list_id])
    |> validate_required([:item, :shopping_list_id])
  end
end
