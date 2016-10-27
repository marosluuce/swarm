defmodule Swarm.Colony.Supervisor do
  use Supervisor

  def init([]) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Swarm.Ai, [], restart: :temporary),
      worker(Swarm.Colony.FoodStore, []),
      supervisor(Swarm.Colony.Drone.Supervisor, [])
    ]

    opts = [strategy: :one_for_one]
    supervise(children, opts)
  end

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: Swarm.Colony.Supervisor)
  end
end
