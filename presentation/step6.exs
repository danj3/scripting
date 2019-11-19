defmodule Step6 do
  @moduledoc "Incorporate Scripting"

  use Scripting
  @switches [ app: :string ]
  @aliases [ a: :app ]

  @doc "\nhelp documentation for this verb"
  command( "verb", [ "alias" ] ) do
    IO.inspect( opts: opts ) # parsed switches that precede the verb
    IO.inspect( args: args ) # positional args after verb
  end

  command_default() # handles unknown verbs
end
Step6.run()
