defmodule WebhookTest do
  use ExUnit.Case
  doctest Webhook

  test "greets the world" do
    assert Webhook.hello() == :world
  end
end
