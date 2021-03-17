defmodule InterfaceLike.Logger do
  @type level:: (:info | :warning | :error)
  @type log_list :: list({ level(), String.t() })

  @callback log_message(log_list(), level(), String.t()) :: log_list()
  @callback log_data(log_list(), level(), any()) ::log_list()
end
