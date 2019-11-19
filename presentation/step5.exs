defmodule Step5 do
  @moduledoc "How do type and strict work?"
  def main do
    OptionParser.parse( System.argv(),
      strict: [
        say: :string,
        many: :keep,
        onoff: :boolean,
                incr: :count,
      ],
      aliases: [
        m: :many,
        i: :incr
      ]
    )
    |> IO.inspect( pretty: true, syntax_colors: [ atom: :cyan, string: :green, tuple: :magenta, list: :light_yellow ])
  end
end
Step5.main()

# elixir step5.exs --say "cour'souvra" -m farm -m dog -m cat
# elixir step5.exs --say "Choedan Kal" -m farm -m dog -m cat -s foo --granny farm alpha
# elixir step5.exs --say "Far Madding" --onoff --incr -i
# Go back to presentation
