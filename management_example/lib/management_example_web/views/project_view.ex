defmodule ManagementExampleWeb.ProjectView do
  use ManagementExampleWeb, :view
  use JaSerializer.PhoenixView

  attributes [:title, :description]
end
