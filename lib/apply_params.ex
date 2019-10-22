defmodule ApplyParams do
  @moduledoc """
  This module provides an easy way to use params lib.

  Instead of matching on changeset you can match on ok-error tuples.

      # Your default params definition from Params.
      defparams index_params %{x: :integer, y: :string}

      def index(conn, params) do
        with {:ok, filters} <- apply_params(:index_params, params) do
          list = get_list(filters)
          render(conn, "index.html", list: list)
        end
      end

  Here errors should be handled in a fallback controller.
  """

  @doc """
  Receives params definition name as an atom as a first argument and
  params from a controller method as a second one.

  Returns either ok-tuple with params atom map, or error-tuple with an
  invalid changeset.
  """
  defmacro apply_params(name, params) do
    quote bind_quoted: [name: name, params: params] do
      # `Params.defparams/1` macro creates a module with the following name
      # and defines a function with the name suplied to that macro which calls
      # a function `from/1` from that module.
      module_name = Params.Def.module_concat(Params, __MODULE__, name)

      case module_name.from(params) do
        %_{valid?: true} = changeset ->
          {:ok, Params.to_map(changeset)}

        error_changeset ->
          {:error, error_changeset}
      end
    end
  end
end
