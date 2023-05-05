# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Blog.Repo.insert!(%Blog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Blog.Products

Products.create_product(%{name: "Tomato"})
Products.create_product(%{name: "Tamarind"})
Products.create_product(%{name: "Tomatillo"})
Products.create_product(%{name: "duck brest"})
Products.create_product(%{name: "Garlic"})
Products.create_product(%{name: "Celery"})
Products.create_product(%{name: "Carrots"})
Products.create_product(%{name: "Clams"})
Products.create_product(%{name: "Clam Juice"})
