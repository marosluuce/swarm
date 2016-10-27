defmodule Swarm.Http.UrlTest do
  use ExUnit.Case, async: true

  test "it formats a partial url" do
    assert "http://url/foo" == Swarm.Http.Url.format("foo")
  end
end
