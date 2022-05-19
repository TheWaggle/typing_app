defmodule Typing.Utils.Execution do
  @file_path("priv/static/result.exs")

  def execution(expr) do
    File.write(@file_path, expr)
    try do
      throw(Code.eval_file(@file_path))
    rescue
      _x in ArgumentError -> "ArgumentError"
      _x in UndefinedFunctionError -> "UndefiledFunctionError"
      _x in CompileError -> "CompileError"
      _x in SyntaxError -> "SyntaxError"
      _x in FunctionClauseError -> "FunctionClauseError"
      x -> x
    catch
      x -> x
    end
  end
end
