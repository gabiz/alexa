defmodule PhoenixAlexa.System do
  alias PhoenixAlexa.{User, Device}

  defstruct user: %User{},
            device: %Device{}
end
