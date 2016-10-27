use Mix.Config

config :swarm,
  http_client: Swarm.Http.FakeClient,
  base_url: "http://url"
