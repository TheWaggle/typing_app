alias Typing.Repo
alias Typing.Game

themes = [
  {"Enum.map([1, 2, 3], fn a -> a * 2 end)", "リストの各要素に対して処理をした結果をリストとして返します。"},
  {"Enum.shuffle([1, 2, 3])", "シャッフルされた要素を含むリストを返します。"},
  {"Enum.map([1, 2, 3])", "引数が足りないため関数が見つからないエラー（UndefiledFunctionError）を返します。"},
  {"Enum.chunk_every([1, 2, 3, 4, 5], 2)", "それぞれ指定した数の要素を含むリストのリストを返します。"},
  {"String.length(\"Hello\")", "UTF-8文字列内のUnicode書式の数を返します。"},
  {"String.at(\"Hello\", 0)", "指定された場所の文字列を返します。"},
  {"List.insert_at([1, 2, 3, 4], 2, 0)", "指定されたインデックス（リストの場所）に指定した要素を挿入します。"},
  {"List.flatten([[1, 2, 3], [4, [5, 6, [7]]]])", "リストのネストを平らにします。"},
  {"DateTime.now(\"Etc/UTC\")", "指定されたタイムゾーンの現在日時を返します。"},
  {"Map.put(%{a: 1, b: 2}, :c, 3)", "指定されたキーとバリューを追加、変更します。"}
]

for {theme, description} <- themes do
  struct =
    %Game.Theme{
      theme: theme,
      description: description
    }

  Repo.insert(struct)
end
