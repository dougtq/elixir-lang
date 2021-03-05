defmodule SchedulerWeb.SchedulingControllerTest do
  use SchedulerWeb.ConnCase

  alias Scheduler.Schedule

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:scheduling) do
    {:ok, scheduling} = Schedule.create_scheduling(@create_attrs)
    scheduling
  end

  describe "index" do
    test "lists all schedulings", %{conn: conn} do
      conn = get(conn, Routes.scheduling_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Schedulings"
    end
  end

  describe "new scheduling" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.scheduling_path(conn, :new))
      assert html_response(conn, 200) =~ "New Scheduling"
    end
  end

  describe "create scheduling" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.scheduling_path(conn, :create), scheduling: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.scheduling_path(conn, :show, id)

      conn = get(conn, Routes.scheduling_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Scheduling"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.scheduling_path(conn, :create), scheduling: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Scheduling"
    end
  end

  describe "edit scheduling" do
    setup [:create_scheduling]

    test "renders form for editing chosen scheduling", %{conn: conn, scheduling: scheduling} do
      conn = get(conn, Routes.scheduling_path(conn, :edit, scheduling))
      assert html_response(conn, 200) =~ "Edit Scheduling"
    end
  end

  describe "update scheduling" do
    setup [:create_scheduling]

    test "redirects when data is valid", %{conn: conn, scheduling: scheduling} do
      conn = put(conn, Routes.scheduling_path(conn, :update, scheduling), scheduling: @update_attrs)
      assert redirected_to(conn) == Routes.scheduling_path(conn, :show, scheduling)

      conn = get(conn, Routes.scheduling_path(conn, :show, scheduling))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, scheduling: scheduling} do
      conn = put(conn, Routes.scheduling_path(conn, :update, scheduling), scheduling: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Scheduling"
    end
  end

  describe "delete scheduling" do
    setup [:create_scheduling]

    test "deletes chosen scheduling", %{conn: conn, scheduling: scheduling} do
      conn = delete(conn, Routes.scheduling_path(conn, :delete, scheduling))
      assert redirected_to(conn) == Routes.scheduling_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.scheduling_path(conn, :show, scheduling))
      end
    end
  end

  defp create_scheduling(_) do
    scheduling = fixture(:scheduling)
    %{scheduling: scheduling}
  end
end
