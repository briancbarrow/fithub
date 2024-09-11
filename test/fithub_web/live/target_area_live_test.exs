defmodule FithubWeb.TargetAreaLiveTest do
  use FithubWeb.ConnCase

  import Phoenix.LiveViewTest
  import Fithub.TrackFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_target_area(_) do
    target_area = target_area_fixture()
    %{target_area: target_area}
  end

  describe "Index" do
    setup [:create_target_area]

    test "lists all target_areas", %{conn: conn, target_area: target_area} do
      {:ok, _index_live, html} = live(conn, ~p"/target_areas")

      assert html =~ "Listing Target areas"
      assert html =~ target_area.name
    end

    test "saves new target_area", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/target_areas")

      assert index_live |> element("a", "New Target area") |> render_click() =~
               "New Target area"

      assert_patch(index_live, ~p"/target_areas/new")

      assert index_live
             |> form("#target_area-form", target_area: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#target_area-form", target_area: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/target_areas")

      html = render(index_live)
      assert html =~ "Target area created successfully"
      assert html =~ "some name"
    end

    test "updates target_area in listing", %{conn: conn, target_area: target_area} do
      {:ok, index_live, _html} = live(conn, ~p"/target_areas")

      assert index_live |> element("#target_areas-#{target_area.id} a", "Edit") |> render_click() =~
               "Edit Target area"

      assert_patch(index_live, ~p"/target_areas/#{target_area}/edit")

      assert index_live
             |> form("#target_area-form", target_area: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#target_area-form", target_area: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/target_areas")

      html = render(index_live)
      assert html =~ "Target area updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes target_area in listing", %{conn: conn, target_area: target_area} do
      {:ok, index_live, _html} = live(conn, ~p"/target_areas")

      assert index_live |> element("#target_areas-#{target_area.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#target_areas-#{target_area.id}")
    end
  end

  describe "Show" do
    setup [:create_target_area]

    test "displays target_area", %{conn: conn, target_area: target_area} do
      {:ok, _show_live, html} = live(conn, ~p"/target_areas/#{target_area}")

      assert html =~ "Show Target area"
      assert html =~ target_area.name
    end

    test "updates target_area within modal", %{conn: conn, target_area: target_area} do
      {:ok, show_live, _html} = live(conn, ~p"/target_areas/#{target_area}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Target area"

      assert_patch(show_live, ~p"/target_areas/#{target_area}/show/edit")

      assert show_live
             |> form("#target_area-form", target_area: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#target_area-form", target_area: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/target_areas/#{target_area}")

      html = render(show_live)
      assert html =~ "Target area updated successfully"
      assert html =~ "some updated name"
    end
  end
end
