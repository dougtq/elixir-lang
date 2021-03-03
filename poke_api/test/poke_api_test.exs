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

  test "it returns 200 on /favicon.ico fetch" do
    # Create a test connection
    conn = conn(:get, "/favicon.ico")

    # Invoke the plug
    conn = PokeApi.Router.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == ""
  end

  test "it returns 404 on non existent route fetch" do
    # Create a test connection
    conn = conn(:get, "/non_existent")

    # Invoke the plug
    conn = PokeApi.Router.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 404
  end

  test "it returns 404 on poke not found" do
    # Create a test connection
    conn = conn(:get, "/poke/doug")

    # Invoke the plug
    conn = PokeApi.Router.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 404
  end

  test "it returns 200 on poke found" do
    # Create a test connection
    conn = conn(:get, "/poke/mewtwo")

    # Invoke the plug
    conn = PokeApi.Router.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
  end
end
