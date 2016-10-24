defmodule SimpleAuth.UserController do
  use SimpleAuth.Web, :controller

  alias SimpleAuth.User

  plug :scrub_params, "user" when action in [:create]

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.html", user: user)
  end

  def new(conn, _params) do
    user = User.changeset(%User{})
    render(conn, "new.html", user: user)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = %User{} |> User.registration_changeset(user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> SimpleAuth.Auth.login(user)
        |> put_flash(:info, "#{user.name} was created!")
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} ->
        conn
        |> render("new.html", user: changeset)
    end
  end
end
