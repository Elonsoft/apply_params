# ApplyParams

This module provides an easy way to use params lib.

## Usage

Instead of matching on changeset you can match on ok-error tuples.

```elixir
use Params

import ApplyParams

# Your default params definition from Params.
defparams index_params %{x: :integer, y: :string}

def index(conn, params) do
  with {:ok, filters} <- apply_params(:index_params, params) do
    list = get_list(filters)
    render(conn, "index.html", list: list)
  end
end
```

Here errors should be handled in a fallback controller.

`apply_params/2` macro receives params definition name as an atom as a
first argument and params from a controller method as a second one.

It returns either ok-tuple with params atom map, or error-tuple with an
invalid changeset.

## Installation

The package can be installed by adding `apply_params` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [
    {
      :apply_params,
      git: "https://github.com/Elonsoft/apply_params.git",
      commit: "<put its latest commit here>"
    }
  ]
end
```
