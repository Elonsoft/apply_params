defmodule ApplyParams.MixProject do
  use Mix.Project

  def project do
    [
      app: :apply_params,
      version: "1.0.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:params, "~> 2.0"}
    ]
  end
end
