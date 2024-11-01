defmodule RinhaWeb.Router do
  use RinhaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RinhaWeb do
    pipe_through :api
    get("/clientes/:id/extrato", ExtratoController, :handle)
    post("/clientes/:id/transacoes", TransactionController, :handle)
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:rinha_2024, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: RinhaWeb.Telemetry
    end
  end
end
