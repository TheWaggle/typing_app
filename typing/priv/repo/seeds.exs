Logger.configure(level: :warning)

file_names = ~w(
  core_account
  admin_account
  game_theme
)

for file_name <- file_names do
  IO.puts(file_name)
  path = Path.join([__DIR__, "seeds", file_name <> ".exs"])
  Code.eval_file(path)
end
