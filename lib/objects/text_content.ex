defmodule PhoenixAlexa.Objects.TextContent do
  alias PhoenixAlexa.Objects.{TextField}
  defstruct primaryText: %TextField{},
            secondaryText: %TextField{},
            tertiaryText: %TextField{}

end
