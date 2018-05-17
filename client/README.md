# BeamwareClient

An elixir client app used to interface with the BeamwareWeb server

To run the client app:

* Start the BeamwareWeb server
* start the client

`iex -S mix`

```elixir
iex> DeviceChannel.join
%{event: "phx_join", payload: %{}, ref: "1", topic: "device:lobby"}
17:14:28.037 [info]  Joined channel as hub-1234
```
