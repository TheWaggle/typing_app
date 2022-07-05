defmodule Typing.GameTest do
  use Typing.DataCase
  alias Typing.Game

  describe "get_themes/0" do
    test "登録されているお題を全て取得します。" do
      theme = "Enum.shuffle([1, 2, 3])"
      description = "シャッフルされた要素を含むリストを返します。"

      for _num <- 1..3 do
        struct =
          %Game.Theme{
            theme: theme,
            description: description
          }

        Repo.insert(struct)
      end

      themes = Game.get_themes()

      assert match?([%Game.Theme{}, %Game.Theme{}, %Game.Theme{}], themes)
    end
  end
end
