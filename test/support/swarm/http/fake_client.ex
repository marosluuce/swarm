defmodule Swarm.Http.FakeClient do

  def get(url) do
    Swarm.Http.Url.format(url)
  end
end
