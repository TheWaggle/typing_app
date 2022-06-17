defmodule TypingWeb.AdminThemeEditorView do
  use TypingWeb, :view
  import Ecto.Changeset

  def format_date(date_time) do
    Calendar.strftime(date_time, "%Y年%-m月%d日")
  end

  def get_theme_for_changeset(changeset) do
    get_field(changeset, :theme)
  end
end
