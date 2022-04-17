defmodule TypingWeb.HomeEditorLive do
  use Phoenix.LiveView

  def render(assigns), do: TypingWeb.HomeEditorView.render(assigns.template, assigns)

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:page_title, "ホーム")
      |> assign(:template, "main.html")

    {:ok, socket}
  end
end
