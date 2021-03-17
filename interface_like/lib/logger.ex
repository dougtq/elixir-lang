defmodule InterfaceLike.LoggerExample do
  @behaviour InterfaceLike.Logger

  alias InterfaceLike.Logger

  @impl Logger
  @spec log_message(Logger.log_list(), Logger.level(), String.t()) :: Logger.log_list()
  def log_message(log_list, level, message) do
    [{ level, message } | log_list]
  end

  @impl Logger
  @spec log_data(Logger.log_list(), Logger.level(), any()) :: Logger.log_list()
  def log_data(log_list, level, data) do
    [{ level, inspect(data) } | log_list ]
  end
end
