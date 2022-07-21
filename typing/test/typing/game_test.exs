defmodule Typing.GameTest do
  use Typing.DataCase
  alias Typing.Factory
  alias Typing.Game
  alias Typing.Repo

  describe "get_theme/1" do
    test "idで登録されているお題を取得します。" do
      create_theme = Factory.insert!(:game_themes)

      get_theme = Game.get_theme(create_theme.id)

      assert match?(%Game.Theme{}, get_theme)
      assert create_theme.id == get_theme.id
    end

    test "存在しないidの場合はnilを取得します。" do
      id = Ecto.UUID.generate()

      get_theme = Game.get_theme(id)

      assert nil == get_theme
    end

    test "id以外の値の場合はnilを取得します。" do
      id = "a"

      get_theme = Game.get_theme(id)

      assert nil == get_theme
    end
  end

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

  describe "update_theme/2" do
    test "お題を更新できたらGame.Theme構造体を取得します。" do
      theme = "Enum.map([1, 2, 3], fn a -> a * 2 end)"

      description = "リストの要素に対して処理をした結果をリストとして返す。"

      create_theme = Factory.insert!(:game_themes, %{theme: theme, description: description})

      attrs = %{theme: "Enum.filter([1, 2, 3])"}

      update_theme = Game.update_theme(create_theme, attrs)

      assert match?({:ok, %Game.Theme{theme: "Enum.filter([1, 2, 3])"}}, update_theme)
    end

    test "お題の更新に失敗した場合はチェンジセットを取得します。" do
      theme = "Enum.map([1, 2, 3], fn a -> a * 2 end)"

      description = "リストの要素に対して処理をした結果をリストとして返す。"

      create_theme = Factory.insert!(:game_themes, %{theme: theme, description: description})

      attrs = %{theme: ""}

      update_theme = Game.update_theme(create_theme, attrs)

      assert match?({:error, %Ecto.Changeset{}}, update_theme)
    end
  end

  describe "delete_theme/1" do
    test "お題を削除したらGame.Theme構造体を取得します。" do
      theme = "Enum.map([1, 2, 3], fn a -> a * 2 end)"

      description = "リストの要素に対して処理をした結果をリストとして返す。"

      create_theme = Factory.insert!(:game_themes, %{theme: theme, description: description})

      delete_theme = Game.delete_theme(create_theme)

      assert match?({:ok, %Game.Theme{}}, delete_theme)

      assert match?(nil, Repo.get(Game.Theme, create_theme.id))
    end

    test "Game.Theme構造体以外の値を受け取った場合はnilを取得します。" do
      delete_theme = Game.delete_theme(1)

      assert nil == delete_theme
    end
  end
end
