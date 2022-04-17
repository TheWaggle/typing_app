defmodule TypingWeb.GameEditorLive do
  use Phoenix.LiveView
  require Logger

  def render(assigns), do: TypingWeb.GameEditorView.render(assigns.template, assigns)

  def mount(params, _session, socket) do
    Logger.info(params)
    socket =
      socket
      |> assign(:page_title, "ゲーム")
      |> assign(:template, "main.html")

    {:ok, socket}
  end
end
