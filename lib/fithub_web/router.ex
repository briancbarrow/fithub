defmodule FithubWeb.Router do
  use FithubWeb, :router

  import FithubWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {FithubWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FithubWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", FithubWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:fithub, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: FithubWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", FithubWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{FithubWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", FithubWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{FithubWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email

      live "/exercises", ExerciseLive.Index, :index
      live "/exercises/new", ExerciseLive.Index, :new
      live "/exercises/:id/edit", ExerciseLive.Index, :edit

      live "/exercises/:id", ExerciseLive.Show, :show
      live "/exercises/:id/show/edit", ExerciseLive.Show, :edit

      live "/target_areas", TargetAreaLive.Index, :index
      live "/target_areas/new", TargetAreaLive.Index, :new
      live "/target_areas/:id/edit", TargetAreaLive.Index, :edit

      live "/target_areas/:id", TargetAreaLive.Show, :show
      live "/target_areas/:id/show/edit", TargetAreaLive.Show, :edit

      live "/roles", RoleLive.Index, :index
      live "/roles/new", RoleLive.Index, :new
      live "/roles/:id/edit", RoleLive.Index, :edit

      live "/roles/:id", RoleLive.Show, :show
      live "/roles/:id/show/edit", RoleLive.Show, :edit

      live "/permissions", PermissionLive.Index, :index
      live "/permissions/new", PermissionLive.Index, :new
      live "/permissions/:id/edit", PermissionLive.Index, :edit

      live "/permissions/:id", PermissionLive.Show, :show
      live "/permissions/:id/show/edit", PermissionLive.Show, :edit
    end
  end

  scope "/", FithubWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{FithubWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
