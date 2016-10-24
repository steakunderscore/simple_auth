defmodule SimpleAuth.PostController do
  use SimpleAuth.Web, :controller

  alias SimpleAuth.Post
  alias SimpleAuth.User

  plug :scrub_params, "post" when action in [:create, :update]

  def action(conn, _) do
    apply(__MODULE__, action_name(conn),
          [conn, conn.params, conn.assigns.current_user])
  end

  def index(conn, %{"user_id" => user_id}, current_user) do
    user = User |> Repo.get!(user_id)

    posts =
      user
      |> user_posts
      |> Repo.all
      |> Repo.preload(:user)

    render(conn, "index.html", posts: posts, user: user)
  end

  def show(conn, %{"id" => id}, current_user) do
  end

  def new(conn, _params, current_user) do
  end

  def create(conn, %{"post" => post_params}, current_user) do
  end

  def edit(conn, %{"id" => id}, current_user) do
  end

  def update(conn, %{"id" => id, "post" => post_params}, current_user) do
  end

  def delete(conn, %{"id" => id}, current_user) do
  end

  defp user_posts(user) do
    assoc(user, :posts)
  end

  defp user_post_by_id(user, post_id) do
    user
    |> user_posts
    |> Repo.get(post_id)
  end
end
