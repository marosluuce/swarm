defmodule Swarm.Client do
  @http_client Application.get_env(:swarm, :http_client)

  def join(name) do
    @http_client.get("join/#{name}")
    |> evaluate
  end

  def create(nest_id) do
    @http_client.get("#{nest_id}/spawn")
    |> evaluate
  end

  def move(ant_id, direction) do
    @http_client.get("#{ant_id}/move/#{to_string(direction)}")
    |> evaluate
  end

  def look(ant_id) do
    @http_client.get("#{ant_id}/look")
    |> evaluate
  end

  def info(id) do
    @http_client.get("#{id}/info")
    |> evaluate
  end

  defp evaluate(response) do
    {:ok, response["message"]}
  end
end
