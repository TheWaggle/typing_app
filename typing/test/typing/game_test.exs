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
end
