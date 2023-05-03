defmodule Blog.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  import Ecto.Query.API, only: [ilike: 2]

  alias Blog.Products.Product

  schema "products" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def filter_by_name(name) do
    search = "%#{name}%"

    query =
      from p in Product,
        where: ilike(p.name, ^search),
        select: p.name
  end
end
