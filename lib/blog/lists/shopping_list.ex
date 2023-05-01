defmodule Blog.Lists.ShoppingList do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shopping_lists" do
    field :list_name, :string
    field :product_id, :id

    timestamps()
  end

  @doc false
  def changeset(shopping_list, attrs) do
    shopping_list
    |> cast(attrs, [:list_name])
    |> validate_required([:list_name])
  end
end
