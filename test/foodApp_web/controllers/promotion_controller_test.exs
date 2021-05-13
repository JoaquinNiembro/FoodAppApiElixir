defmodule FoodAppWeb.PromotionControllerTest do
  use FoodAppWeb.ConnCase

  alias FoodApp.Restaurants
  alias FoodApp.Restaurants.Promotion

  @create_attrs %{
    discount: "some discount",
    promotion: "some promotion",
    title: "some title"
  }
  @update_attrs %{
    discount: "some updated discount",
    promotion: "some updated promotion",
    title: "some updated title"
  }
  @invalid_attrs %{discount: nil, promotion: nil, title: nil}

  def fixture(:promotion) do
    {:ok, promotion} = Restaurants.create_promotion(@create_attrs)
    promotion
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all promotions", %{conn: conn} do
      conn = get(conn, Routes.promotion_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create promotion" do
    test "renders promotion when data is valid", %{conn: conn} do
      conn = post(conn, Routes.promotion_path(conn, :create), promotion: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.promotion_path(conn, :show, id))

      assert %{
               "id" => id,
               "discount" => "some discount",
               "promotion" => "some promotion",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.promotion_path(conn, :create), promotion: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update promotion" do
    setup [:create_promotion]

    test "renders promotion when data is valid", %{conn: conn, promotion: %Promotion{id: id} = promotion} do
      conn = put(conn, Routes.promotion_path(conn, :update, promotion), promotion: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.promotion_path(conn, :show, id))

      assert %{
               "id" => id,
               "discount" => "some updated discount",
               "promotion" => "some updated promotion",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, promotion: promotion} do
      conn = put(conn, Routes.promotion_path(conn, :update, promotion), promotion: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete promotion" do
    setup [:create_promotion]

    test "deletes chosen promotion", %{conn: conn, promotion: promotion} do
      conn = delete(conn, Routes.promotion_path(conn, :delete, promotion))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.promotion_path(conn, :show, promotion))
      end
    end
  end

  defp create_promotion(_) do
    promotion = fixture(:promotion)
    %{promotion: promotion}
  end
end
