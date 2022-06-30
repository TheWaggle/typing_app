defmodule TypingWeb.AdminAccountEditorView do
  use TypingWeb, :view

  def get_authority_status(account) do
    case account.authority_status do
      0 -> "閲覧者"
      1 -> "作業者"
      2 -> "管理者"
    end
  end
end
