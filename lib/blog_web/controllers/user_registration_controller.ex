defmodule BlogWeb.UserRegistrationController do
  use BlogWeb, :controller

  alias Blog.Accounts
  alias Blog.Accounts.User
  alias BlogWeb.UserAuth

  def new(conn, _params) do
    changeset =
      Accounts.change_user_registration(%User{})
      |> IO.inspect(label: "user controller line 10")

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &Routes.user_confirmation_url(conn, :edit, &1)
          )

        conn
        |> put_flash(:info, "User created successfully.")
        |> UserAuth.log_in_user(user)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
