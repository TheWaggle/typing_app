defmodule Typing.Utils.Execution do
  @file_path("priv/static/result.exs")

  # 引数 expr にはお題の関数（文字列）が渡される
  # expr を result.exs に書き込み Code.eval_file/2 で実行させます。
  # エラーの場合はそのエラーのモジュール名を返します。
  def execution(expr) do
    File.write(@file_path, expr)

    try do
      throw(Code.eval_file(@file_path))
    rescue
      x ->
        %module{} = x
        module = String.replace("#{module}", "Elixir.", "")
        "#{module}"
    catch
      x -> x
    end
  end
end
