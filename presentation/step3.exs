#!/usr/bin/env elixir
# A script is just like any other Elixir code

defmodule Hello do
  def main do
    IO.puts("hello world")
  end
end
# When using modules, a function has to be called at the
# top level
Hello.main()
