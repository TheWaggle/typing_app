defmodule Typing.Editor.AdminRegistrantEditor do
  alias Typing.Admin
  alias Typing.Core

  defstruct account: nil,
            registrant_list: [],
            mode: :summary

  @type t :: %__MODULE__{
          account: Admin.Account.t(),
          registrant_list: [Core.Account.t()],
          mode: :summary
  }

  def construct(%Admin.Account{} = account) do
    %__MODULE__{
      account: account,
      registrant_list: Core.get_accounts()
    }
  end
end
