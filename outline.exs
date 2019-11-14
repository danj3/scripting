Code.prepend_path(".")
defmodule Example do
  use Scripting
  @switches [ app: :string ]
  @aliases [ a: :app ]

  @doc "help documentation for this verb"
  command( "verb", [ "alias" ] ) do
    IO.inspect( args ) # args after verb
    IO.inspect( opts ) # parsed switches that precede the verb
  end

  command_default() # handles unknown verbs
end
Example.run()
