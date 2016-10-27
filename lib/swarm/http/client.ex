defmodule Swarm.Http.Client do

  def get(url) do
    response = url
    |> Swarm.Http.Url.format
    |> HTTPoison.get!

    Poison.Parser.parse!(response.body)
  end
end
