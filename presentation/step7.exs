defmodule Example do
  use Scripting

  @switches []
  @aliases []

  @moduledoc """
  An example of how to build basic commands
  """

  @doc """
  <program_name>
  Find the path of a program

  Uses only Elixir functions
  """
  command( "find-program", [ "f" ] ) do
    [ prg ] = args
    System.find_executable( prg )
    |> IO.puts
  end

  @doc """
  <project dir>
  Run mix release for the prod enviroment for a project
  Runs a simple external program
  """
  command( "release", [ "rel" ] ) do
    [ project ] = args
    System.cmd( "mix", [ "release", "--overwrite" ],
      env: [ { "MIX_ENV", "prod" } ],
      cd: project,
      into: IO.stream( :stdio, :line )
    )
  end

  @doc """
  <host>
  ssh to a host as simple interactive example
  How to run an external interactive command
  """
  command( "ssh" ) do
    [ host ] = args
    System.cmd( "tmux",
      [ "new-window", "-t", tmux_session(), "ssh #{host}" ],
    into: IO.stream( :stdio, :line ) )
  end

  @doc """
  <any valid emacs arguments>
  start emacs in terminal mode
  Another external interactive program
  """
  command( "emacs" ) do
    System.cmd( "tmux",
      [ "new-window", "-t", tmux_session(), "emacs -nw " <> Enum.join( args, " " ) ],
    into: IO.stream( :stdio, :line ) )
  end

  command_default()
end

Example.run
