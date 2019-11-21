# Scripting

The Scripting module is a no-dependency portable elixir module that
  eases starting and writing scripts in elixir.

# Resources

## generator

The generator can be used to create a script starting point template. It can
generate templates or embed the `Scripting` module either as a BEAM or source
for the most portability.

The generator is written using the `Scripting` module.

## presentation

Check out the `presentation` directory for a progression of examples
for scripts.

Please read the next section about making `Scripting` available for thse
examples.

# Embed `Scripting`

The scripting project does not have any dependencies and does not
require `mix`. This project can be added as a dependency to another
mix project and then used for writing scripts run with `mix run`.

The more interesting use case is writing stand-alone script that only
depends on access to `elixir`, the base install.

## For development

Compile the module:

```elixir
elixirc lib/scripting.ex
```

This will create `Elixir.Scripting.beam`. A script under development can
be run directly as long as this beam file is in your current directory since `.`
is in the default code loading path.

## For portability

The following strategies can be used to portably deploy a script:

### Colocate the beam file

Put a copy of the `Elixir.Scripting.beam` file into the same directory as
your script and add the following line as the second line of your script:

```elixir
Code.append_path( Path.dirname( __ENV__.file() ) )
```

`__ENV__.file()` will resolve to the full path of the script being run
and is conceptually the same as argv0.

### Install a common copy

Put a copy of the beam file into a common directory. For example,
a ~/ebin, add this as your line 2:

```elixir
Code.append_path( Path.join( System.user_home(), "ebin" ) )
```

### Embed `Scripting`

The `generator` can embed the source of the module or the beam file itself
into your script. Look at embed-with-source or embed-with-beam. These will
wrap your script and output to a new file. The script is still source and can be
edited.

Note that embedding the beam file is more portable than you might expect. A beam
file compiled on x86 can be used on an ARM, and vice-versa. The only real requirement
is that the emulator version has to be equal or greater than the one it's compiled
with. The generator will also embed a check of the beam version.


## Installation

Install as a dependency with:

```elixir
def deps do
  [
    {:scripting, "~> 1.0.0"}
  ]
end
```

To develop independent script, clone this repo:

`git clone https://github.com/danj3/scripting`

Documentation is at [https://hexdocs.pm/scripting](https://hexdocs.pm/scripting).

