use Mix.Config

config :swarm,
  http_client: Swarm.Http.Client,
  base_url: "http://localhost:4000/api",
  team_name: "Me"

import_config "#{Mix.env}.exs"
