defmodule Typing.Utils.Execution do
  @file_path("priv/static/result.exs")

  # 引数 expr にはお題の関数（文字列）が渡される
  # expr を result.exs に書き込み Code.eval_file/2 で実行させます。
  def execution(expr) do
    File.write(@file_path, expr)

    Code.eval_file(@file_path)
  end
end
