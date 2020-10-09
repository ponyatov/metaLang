#  powered by metaL: https://github.com/ponyatov/metaL/wiki/metaL-manifest
defmodule Metalang.MixProject do
  use Mix.Project

  def project do
    [
      # \ <section:project>
      app: :metalang,
      version: "0.0.1",
      name: "metaLang",
      description: "metaL implementation in Elixir/Erlang [homoiconic (meta)language for source code transformations]",
      source_url: "https://github.com/ponyatov/metaL/tree/master/metaLang",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      docs: [extras: ["README.md"]],
      package: package(),
      deps: deps()
      # / <section:project>
    ]
  end

  def application do
    [
      # \ <section:application>
      extra_applications: [:logger]
      # / <section:application>
    ]
  end

  defp deps do
    [
      # \ <section:deps>
      # {:exsync, "~> 0.2", only: :dev},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
      # / <section:deps>
    ]
  end

  defp package do
    [
      name: "metalang",
      files: ~w(lib src .formatter.exs mix.exs README* LICENSE*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/ponyatov/metaL/tree/master/metaLang"},
      maintainers: ["Dmitry Ponyatov <dponyatov@gmail.com>"]
    ]
  end
end
