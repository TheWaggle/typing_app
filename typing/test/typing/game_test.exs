defmodule Typing.GameTest do
  use Typing.DataCase
  alias Typing.Factory
  alias Typing.Game

  describe "get_themes/0" do
    test "登録されているお題を全て取得します。" do
      theme = "Enum.shuffle([1, 2, 3])"
      description = "シャッフルされた要素を含むリストを返します。"

      for _num <- 1..3 do
        Factory.insert!(:game_themes, %{theme: theme, description: description})
      end

      themes = Game.get_themes()

      assert match?([%Game.Theme{}, %Game.Theme{}, %Game.Theme{}], themes)
    end

    test "登録されているお題が0個の場合は空のリストを取得します。" do
      themes = Game.get_themes()

      assert [] == themes
    end
  end

  describe "create_theme/1" do
    test "お題を登録できたらGame.Theme構造体を取得します。" do
      theme = "Enum.map([1, 2, 3], fn a -> a * 2 end)"

      description = "リストの各要素に対して処理をした結果をリストとして返す。"

      attrs = %{theme: theme, description: description}

      create_theme = Game.create_theme(attrs)

      assert match?({:ok, %Game.Theme{}}, create_theme)
    end

    test "お題の登録に失敗した場合はチェンジセットを取得します。" do
      attrs = %{theme: "", description: ""}

      create_theme = Game.create_theme(attrs)

      assert match?({:error, %Ecto.Changeset{}}, create_theme)
    end
  end
end
