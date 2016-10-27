defmodule Swarm.Mixfile do
  use Mix.Project

  def project do
    [app: :swarm,
     version: "0.1.0",
     elixir: "~> 1.3",
     elixirc_paths: elixirc_paths(Mix.env),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     deps: deps()]
  end

  def application do
    [mod: {Swarm, []},
     applications: [:logger, :httpoison, :ant_battles]]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  defp deps do
   [{:httpoison, "~> 0.9.0"},
    {:poison, "~> 2.0"},
    {:ant_battles, in_umbrella: true}]
  end
end
