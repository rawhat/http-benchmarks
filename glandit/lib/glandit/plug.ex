defmodule Glandit.Plug do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "")
  end

  post "/" do
    send_resp(conn, 200, "")
  end

  get "/user/:id" do
    send_resp(conn, 200, id)
  end

  post "/user" do
    {:ok, body, conn} = Plug.Conn.read_body(conn)
    send_resp(conn, 200, body)
  end
end
