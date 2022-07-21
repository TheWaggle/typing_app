defmodule Typing.Editor.AdminThemeEditor do
  alias Typing.Admin
  alias Typing.Game

  defstruct account: nil,
            mode: :summary,
            themes: []

  @type t :: %__MODULE__{
          account: Admin.Account.t(),
          mode: :summary,
          themes: [Game.Theme.t()] | []
  }

  def construct(%Admin.Account{} = account) do
    %__MODULE__{
      account: account,
      themes: Game.get_themes()
    }
  end
end
