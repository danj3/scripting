#!/usr/bin/env elixir
# How about switches?

defmodule Hello do
  def main do
    { opts, _args, _err } =
      OptionParser.parse( System.argv(),
        switches: [ say: :string ] )
    IO.puts( "hello world!, I have something to say:\n" <>
      Keyword.fetch!( opts,  :say ) )
  end
end
Hello.main()

# elixir step4.exs --say 'Elixir is great!'
