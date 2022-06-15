alias Typing.Repo
alias Typing.Game

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
