defmodule SimpleAuth.Router do
  use SimpleAuth.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :login_required do
  end

  pipeline :admin_required do
  end

  pipeline :with_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug SimpleAuth.CurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SimpleAuth do
    pipe_through [:browser, :with_session]

    get "/", PageController, :index

    resources "/sessions", SessionController, only: [:new, :create, :delete]

    resources "/users", UserController, only: [:show, :new, :create]

    scope "/" do
      pipe_through :login_required

      resources "/users", UserController, only: [:show] do
        resources "/posts", PostController
      end

      scope "/admin", Admin, as: :admin do
        pipe_through :admin_required

        resources "/users", UserController, only: [:index, :show] do
          resources "/posts", PostController, only: [:index, :show]
        end
      end
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", SimpleAuth do
  #   pipe_through :api
  # end
end
