defmodule PhoenixAlexa.Objects.Image do

  defstruct contentDescription: "",
            sources: []

  def add_source(image,url) do
    Map.merge(image, %{sources: image.sources ++ [%{url: url}]})
  end

  def set_description(image, content) do
    Map.merge(image, %{ contentDescription: content})
  end

end
