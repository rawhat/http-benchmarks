defmodule GlanditTest do
  use ExUnit.Case
  doctest Glandit

  test "greets the world" do
    assert Glandit.hello() == :world
  end
end
