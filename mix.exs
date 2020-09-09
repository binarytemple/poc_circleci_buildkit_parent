defmodule PocCircleciBuildkitParent.MixProject do
  use Mix.Project

  def project do
    [
      app: :poc_circleci_buildkit_parent,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:poc_circleci_buildkit_child, git: "git@github.com:esl/poc_circleci_buildkit_child.git", branch: "master"}
    ]
  end
end
