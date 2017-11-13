defmodule PhoenixAlexa.User do
  alias PhoenixAlexa.UserPermissions

  defstruct userId: "",
            accessToken: "",
            permissions: %UserPermissions{}
end
