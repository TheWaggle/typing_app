defmodule TypingWeb.AdminThemeEditorView do
  use TypingWeb, :view

  def format_date(date_time) do
    Calendar.strftime(date_time, "%Y年%-m月%d日")
  end
end
