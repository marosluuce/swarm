defmodule Swarm.Colony.Drone.Supervisor do
  use Supervisor

  def init([]) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Swarm.Colony.Drone, [])
    ]

    opts = [strategy: :simple_one_for_one]
    supervise(children, opts)
  end

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: Swarm.Colony.Drone.Supervisor)
  end
end
