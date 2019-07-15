defmodule PhoenixAlexa.Directives.Hint do

  defstruct type: "Hint",
            hint: %{
                type: "PlainText",
                text: nil
            }
end
