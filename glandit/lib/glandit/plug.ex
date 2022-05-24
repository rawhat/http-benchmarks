defmodule Glandit.Plug do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "")
  end

  get "/user/:id" do
    send_resp(conn, 200, id)
  end

  post "/user" do
    send_resp(conn, 200, conn.body_params)
  end
end