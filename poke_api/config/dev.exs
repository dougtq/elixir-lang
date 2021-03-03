# ./config/dev.exs

use Mix.Config

config :poke_api, cowboy_port: 4300
config :poke_api, poke_api_url: "https://pokeapi.co/api/v2/"
config :poke_api, redis_url: "redis://127.0.0.1:6379"
