defmodule Scripting do
  defmacro __using__( _ ) do
    Module.register_attribute( __CALLER__.module,
      :command_list,
      accumulate: true )

    quote do
      import Scripting
      @before_compile Scripting

      def help_footer do
        "(define help_footer to add a footer)"
      end

      defoverridable help_footer: 0

      command( "help", ["h"] ) do
        help_render( __MODULE__ )
      end
    end
  end

  def doc_format( doc ), do: String.replace( doc, "\n", "\n\t" )
  def help_render( mod ) do
    import IO.ANSI
    IO.puts( mod.help_banner() )
    mod.command_list()
    |> Enum.reverse
    |> Enum.map( fn
      { verb, aliases, doc } ->
        IO.puts("  #{bright()}#{verb}#{alias_format(aliases)}#{reset()} #{doc_format( doc )}\n" )
    end)
    IO.puts( mod.help_footer() )
  end
  def alias_format( nil ), do: ""
  def alias_format( a ) do
    import IO.ANSI
    blue() <> "|" <> yellow() <> Enum.join( a, blue() <> "|" <> yellow() )
  end

  defmacro __before_compile__(env) do
    m =
      case Module.get_attribute( env.module, :moduledoc ) do
        { _, m } -> m
        _ -> "Help banner (use @moduledoc to customize)"
      end

    quote do
      def help_banner do
        unquote( m )
      end

      def command_list, do: @command_list

      def run do
        System.argv()
        |> OptionParser.parse_head( strict: @switches, aliases: @aliases )
        |> case do
             { opts, [ cmd | argv ], [] } ->
               run_command( expand_alias( cmd, command_list() ), argv, opts )
             { _, _, [] } ->
               run_command( "help", nil, nil )
             { _, _, errors } ->
               IO.inspect("Options Problem: #{inspect(errors)}")
           end
      end
    end
  end

  defmacro command_default do

    quote do
      def run_command( any, _, _ ) do
        IO.puts("unknown verb: #{any}\nTry 'help'")
      end
    end

  end


  def expand_alias( cmd, commands ) do
    Enum.find_value( commands, cmd, fn
      { ^cmd, _, _ } -> cmd
      { verb, aliases, _ } when is_list( aliases ) ->
        if Enum.member?( aliases, cmd ), do: verb, else: false
      _ -> false
    end)
  end

  def tmux_session do
    System.get_env("TMUX")
    |> case do
         nil -> raise "This command must run within a tmux session"
         val -> val
       end
    |> Path.split
    |> Enum.at( -1 )
    |> String.split(",")
    |> Enum.at( -1 )
    |> case do
         session -> "$" <> session
       end
  end

  def register_command( %{ module: mod }, verb, aliases ) do
    doc = case Module.delete_attribute( mod, :doc ) do
            { _, d } -> d
            _ -> ""
          end

    Module.put_attribute( mod,
      :command_list,
      { verb, aliases, doc }
    )
  end

  defmacro command( verb, aliases \\ nil, opts ) do

    quote generated: true do

      Scripting.register_command( __ENV__, unquote( verb ), unquote( aliases ) )

      def run_command( unquote( verb ), var!(args), var!(opts) ),
        do: unquote( opts[:do] )

    end
  end
end
