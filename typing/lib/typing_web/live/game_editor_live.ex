defmodule TypingWeb.GameEditorLive do
  use Phoenix.LiveView
  alias Typing.Editor.GameEditor
  alias Typing.Core

  def render(assigns), do: TypingWeb.GameEditorView.render(assigns.template, assigns)

  def mount(_params, session, socket) do
    account = Core.get_account(session["core_account_id"])

    socket =
      socket
      |> assign(:editor, GameEditor.construct(account))
      |> assign(:page_title, "タイピングゲーム")
      |> assign(:template, "main.html")

    if connected?(socket) do
      :timer.send_interval(1000, "timer")
    end

    {:ok, socket}
  end

  def handle_info("timer", socket) do
    socket =
      update(socket, :editor, fn editor ->
        GameEditor.update(editor, "timer")
      end)

    {:noreply, socket}
  end

  def handle_event("toggle_" <> event, params, socket) do
    socket =
      update(socket, :editor, fn editor ->
        GameEditor.update(editor, event, params)
      end)

    {:noreply, socket}
  end
end
