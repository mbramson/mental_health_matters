defmodule MentalHealthMatters.Web.Router do
  use MentalHealthMatters.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :assign_current_user do
    plug MentalHealthMatters.Plug.AssignCurrentUser
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

    resources "/upcoming_appointments", UpcomingAppointmentController, only: [:index]
    resources "/schedule_appointment", ScheduleAppointmentController, only: [:new, :create]
  end

  scope "/", MentalHealthMatters.Web do
    pipe_through [:browser, :assign_current_user]

    resources "/signin", SigninController, only: [:new, :create, :delete]
    resources "/registration", RegistrationController, only: [:new, :create]
    resources "/assessment", AssessmentController, only: [:index]
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", MentalHealthMatters.Web do
  #   pipe_through :api
  # end
end
