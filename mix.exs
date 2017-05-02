defmodule PhoenixAlexa.Mixfile do
  use Mix.Project

  @version File.read!("VERSION") |> String.strip

  def project do
    [app: :phoenix_alexa,
     version: @version,
     elixir: "~> 1.2",
     description: "Alexa library for Phoenix",
     deps: deps(),
     package: package(),
     consolidate_protocols: Mix.env != :test]
  end

  def application do
    [applications: []]
  end

  defp deps do
    [{:poison, "~> 2.0"},
     {:plug, "~> 1.1"},
    ]
  end

  defp package do
    [files: ~w(lib test mix.exs README.md LICENSE VERSION),
     maintainers: ["Gabi Zuniga"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/gabiz/phoenix_alexa"}]
  end
end
