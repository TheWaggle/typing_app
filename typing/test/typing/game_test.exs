defmodule Typing.GameTest do
  use Typing.DataCase
  alias Typing.Game
  alias Typing.Repo

  describe "get_themes/0" do
    test "登録されているお題をすべて取得します。" do
      themes =
        [
          {"Enum.map([1, 2, 3], fn a -> a * 2 end)", "リストの各要素に対して処理をした結果をリストとして返します。"},
          {"Enum.shuffle([1, 2, 3])", "シャッフルされた要素を含むリストを返します。"},
          {"Enum.map([1, 2, 3])", "引数が足りないため関数が見つからないエラー（UndefiledFunctionError）を返します。"}
        ]

      for {theme, description} <- themes do
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
