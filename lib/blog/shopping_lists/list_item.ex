defmodule Blog.ShoppingLists.ListItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "list_items" do
    field :custom_name, :string
    field :quantity, :integer
    field :unit, :string
    field :shopping_list_id, :id
    belongs_to :product, Blog.Products.Product

    timestamps()
  end

  @doc false
  def changeset(list_item, attrs) do
    list_item
    |> cast(attrs, [:quantity, :unit, :custom_name, :shopping_list_id, :product_id])
    |> validate_required([:quantity, :unit])
  end
end
