defmodule FoodApp.RestaurantsTest do
  use FoodApp.DataCase

  alias FoodApp.Restaurants

  describe "promotions" do
    alias FoodApp.Restaurants.Promotion

    @valid_attrs %{discount: "some discount", promotion: "some promotion", title: "some title"}
    @update_attrs %{discount: "some updated discount", promotion: "some updated promotion", title: "some updated title"}
    @invalid_attrs %{discount: nil, promotion: nil, title: nil}

    def promotion_fixture(attrs \\ %{}) do
      {:ok, promotion} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Restaurants.create_promotion()

      promotion
    end

    test "list_promotions/0 returns all promotions" do
      promotion = promotion_fixture()
      assert Restaurants.list_promotions() == [promotion]
    end

    test "get_promotion!/1 returns the promotion with given id" do
      promotion = promotion_fixture()
      assert Restaurants.get_promotion!(promotion.id) == promotion
    end

    test "create_promotion/1 with valid data creates a promotion" do
      assert {:ok, %Promotion{} = promotion} = Restaurants.create_promotion(@valid_attrs)
      assert promotion.discount == "some discount"
      assert promotion.promotion == "some promotion"
      assert promotion.title == "some title"
    end

    test "create_promotion/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Restaurants.create_promotion(@invalid_attrs)
    end

    test "update_promotion/2 with valid data updates the promotion" do
      promotion = promotion_fixture()
      assert {:ok, %Promotion{} = promotion} = Restaurants.update_promotion(promotion, @update_attrs)
      assert promotion.discount == "some updated discount"
      assert promotion.promotion == "some updated promotion"
      assert promotion.title == "some updated title"
    end

    test "update_promotion/2 with invalid data returns error changeset" do
      promotion = promotion_fixture()
      assert {:error, %Ecto.Changeset{}} = Restaurants.update_promotion(promotion, @invalid_attrs)
      assert promotion == Restaurants.get_promotion!(promotion.id)
    end

    test "delete_promotion/1 deletes the promotion" do
      promotion = promotion_fixture()
      assert {:ok, %Promotion{}} = Restaurants.delete_promotion(promotion)
      assert_raise Ecto.NoResultsError, fn -> Restaurants.get_promotion!(promotion.id) end
    end

    test "change_promotion/1 returns a promotion changeset" do
      promotion = promotion_fixture()
      assert %Ecto.Changeset{} = Restaurants.change_promotion(promotion)
    end
  end
end
