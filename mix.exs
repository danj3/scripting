defmodule Scripting.MixProject do
  use Mix.Project

  @version "1.0.0"

  def project do
    [
      app: :scripting,
      version: @version,
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      package: package(),
      description: description(),
      docs: docs(),
    ]
  end

  defp description do
    """
    Make scripting easy with a simple pattern and help generation.
    """
  end

  defp package do
    [
      maintainers: [ "Dan Janowski" ],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/danj3/scripting"},
      files: ["lib/scripting.ex", "mix.exs", "README.md","LICENSE", "generator"]
    ]
  end

  defp docs do
    [
      main: "readme", # The main page in the docs
      name: "Scripting",
      source_ref: "v#{@version}",
      canonical: "http://hexdocs.pm/scripting",
      source_url: "https://github.com/danj3/scripting",
      extras: ["README.md"]
    ]
  end
  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
