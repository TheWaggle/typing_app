defmodule Typing.GameTest do
  use Typing.DataCase
  alias Typing.Factory
  alias Typing.Game

  describe "get_themes/0" do
    test "登録されているお題をすべて取得します。" do
      themes =
        [
          {"Enum.map([1, 2, 3], fn a -> a * 2 end)", "リストの各要素に対して処理をした結果をリストとして返します。"},
          {"Enum.shuffle([1, 2, 3])", "シャッフルされた要素を含むリストを返します。"},
          {"Enum.map([1, 2, 3])", "引数が足りないため関数が見つからないエラー（UndefiledFunctionError）を返します。"}
        ]

      for {theme, description} <- themes do
        Factory.insert!(:game_themes, %{theme: theme, description: description})
      end

      themes = Game.get_themes()

      assert match?([%Game.Theme{}, %Game.Theme{}, %Game.Theme{}], themes)
    end

    test "登録されているお題がない場合は空のリストを取得します。" do
      themes = Game.get_themes()

      assert match?([], themes)
    end
  end

  describe "create_theme/1" do
    test "お題を登録する。" do
      theme = "Enum.map([1, 2, 3], fn a -> a * 2 end)"
      description = "リストの各要素に対して処理をした結果をリストとして返します。"
      attrs = %{theme: theme, description: description}

      create_theme = Game.create_theme(attrs)
      assert match?({:ok, %Game.Theme{}}, create_theme)
    end

    test "お題が登録できない場合はチェンジセットを取得します。" do
      theme = ""
      description = ""
      attrs = %{theme: theme, description: description}

      create_theme = Game.create_theme(attrs) |> IO.inspect()
      assert match?({:error, %Ecto.Changeset{}}, create_theme)
    end
  end
end
