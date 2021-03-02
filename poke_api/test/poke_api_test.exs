defmodule PokeApiTest do
  use ExUnit.Case, async: true
  use Plug.Test
  doctest PokeApi

  test "it returns pong" do
    # Create a test connection
    conn = conn(:get, "/ping")

    # Invoke the plug
    conn = PokeApi.Router.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "pong"
  end
end