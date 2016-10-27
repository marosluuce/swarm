defmodule Swarm.Ai do
  @team_name Application.get_env(:swarm, :team_name)

  def start_link() do
    {:ok, spawn_link(__MODULE__, :init, [])}
  end

  def init() do
    nest = Swarm.Command.join(@team_name)
    Swarm.Colony.Queen.create(nest)
    Swarm.Colony.Queen.start(nest)
  end
end
