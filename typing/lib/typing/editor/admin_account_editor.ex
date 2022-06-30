defmodule Typing.Editor.AdminAccountEditor do
  alias Typing.Admin

  defstruct account: nil,
            mode: :summary

  @type t :: %__MODULE__{
          account: Admin.Account.t(),
          mode: :summary
  }

  def construct(%Admin.Account{} = account) do
    %__MODULE__{
      account: account
    }
  end
end
