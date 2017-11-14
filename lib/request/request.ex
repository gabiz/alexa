defmodule PhoenixAlexa.Request do
  
  alias PhoenixAlexa.{Session, GenericRequest, Context}

  defstruct version: "",
            session: %Session{},
            request: %GenericRequest{},
            context: %Context{}

end
