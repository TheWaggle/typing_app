defmodule Typing.GameTest do
  use Typing.DataCase
  alias Typing.Game

  describe "get_themes/0" do
    test "登録されているお題をすべて取得します。" do
      themes = Game.get_themes()

      assert themes == []
    end
  end
end
