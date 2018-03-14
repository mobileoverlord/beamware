defmodule BeamwareWeb.Plugs.Api.AuthenticateDevice do
  import Plug.Conn

  alias Beamware.Devices
  alias Phoenix.Controller
  alias BeamwareWeb.Api.ErrorView

  def init(_), do: nil

  def call(conn, _) do
    regex = Regex.compile!(".*CN=(?<identifier>[^$]+)")

    with [dn | _] <- get_req_header(conn, "x-client-dn"),
         %{"identifier" => identifier} <- Regex.named_captures(regex, dn),
         {:ok, device} <- Devices.get_device_by_identifier(identifier) do
      conn
      |> assign(:device, device)
    else
      _ ->
        conn
        |> put_status(:unauthorized)
        |> Controller.put_view(ErrorView)
        |> Controller.render("error.json", %{error: "unauthorized"})
        |> halt()
    end
  end
end
