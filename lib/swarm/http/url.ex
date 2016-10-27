defmodule Swarm.Http.Url do
  @base_url Application.get_env(:swarm, :base_url)

  def format(partial) do
    "#{@base_url}/#{partial}"
  end
end
