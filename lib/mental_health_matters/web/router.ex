defmodule MentalHealthMatters.Web.Router do
  use MentalHealthMatters.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authenticate do
    plug MentalHealthMatters.Plug.RequireAuthentication
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MentalHealthMatters.Web do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit]
    resources "/meetings", MeetingController, except: [:new, :edit]
    resources "/availabilities", AvailabilityController, except: [:new, :edit, :update, :delete]
    resources "/login", LoginController, only: [:create]
  end



  scope "/", MentalHealthMatters.Web do
    pipe_through [:browser, :authenticate]

  end

  scope "/", MentalHealthMatters.Web do
    pipe_through :browser

    resources "/signin", SigninController, only: [:new, :create]
    resources "/registration", RegistrationController, only: [:new, :create]
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", MentalHealthMatters.Web do
  #   pipe_through :api
  # end
end
