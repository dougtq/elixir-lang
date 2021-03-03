defmodule PokeApi.Database do
  use Application
  require Logger
  def start(_type, _args) do
    url = Application.get_env(:poke_api, :redis_url, nil)
    Logger.info("connect to url #{url}");
    children = [
      {Redix, {url, [name: :redix]}}
    ]
    case Redix.start_link(children) do
      {:ok, conn} -> {:ok, conn}
      {:error, err} -> {:error, err}
    end
  end

  # get the key function
  def get(key) do
    GenServer.call(:redix, {:get, key})
  end

  # set the key function
  def set(key, value) do
    GenServer.call(:redix, {:set, key, value})
  end

  # handle call for get function
  def handle_call({:get, key}, _from, state) do
    reply = Redix.command(state, ["GET", key])
    {:reply, {:ok, reply}, state}
  end

  # #handle call for set function
  # def handle_call({:set, key, value}, _from, state ) do
  #   new_state = Exq.enqueue(Exq, "q1", SetWorker, [key, value])
  #   {:reply, state, new_state}
  # end
end
