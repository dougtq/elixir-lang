defmodule ManagementExampleWeb.DocumentView do
  use ManagementExampleWeb, :view
  use JaSerializer.PhoenixView

  attributes [:name, :published, :content, :view_count, :project_id]
end
