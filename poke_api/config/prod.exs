# ./config/prod.exs

use Mix.Config

config :poke_api, cowboy_port: 80
config :poke_api, poke_api_url: "https://pokeapi.co/api/v2/"
