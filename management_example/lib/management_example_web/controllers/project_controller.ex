defmodule ManagementExampleWeb.ProjectController do
  use ManagementExampleWeb, :controller

  alias ManagementExample.Management
  alias ManagementExample.Management.Project

  action_fallback ManagementExampleWeb.FallbackController

  def index(conn, _params) do
    projects = Management.list_projects()
    render(conn, "index.json-api", projects: projects)
  end

  def show(conn, %{"id" => id}) do
    project = Management.get_project!(id)
    render(conn, "show.json-api", project: project)
  end

  def update(conn, %{"id" => id, "project" => project_params}) do
    project = Management.get_project!(id)

    with {:ok, %Project{} = project} <- Management.update_project(project, project_params) do
      render(conn, "show.json-api", project: project)
    end
  end

  def delete(conn, %{"id" => id}) do
    project = Management.get_project!(id)

    with {:ok, %Project{}} <- Management.delete_project(project) do
      send_resp(conn, :no_content, "")
    end
  end
end
