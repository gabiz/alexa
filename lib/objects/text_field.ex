defmodule PhoenixAlexa.Objects.TextField do

  defstruct type: "RichText",
            text: ""

  def set_plain_text(text_field,url) do
    Map.merge(text_field, %{type: "PlainText"})
  end

  def set_text(text_field, text) do
    Map.merge(text_field,%{text: text})
  end

end
