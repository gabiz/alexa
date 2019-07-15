defmodule PhoenixAlexa.ShowTest do
  use ExUnit.Case
  use PhoenixAlexa.Controller, :post
  alias PhoenixAlexa.Response
  alias PhoenixAlexa.Objects.{Image,TextField,TextContent}

  test "image" do
    image = %Image{}
      |> Image.set_description("efwef")
      |> Image.add_source("https://example.com/asdf.jpg")

    [%{:url => url}] = image.sources

    assert "efwef" == image.contentDescription
    assert "https://example.com/asdf.jpg" == url
  end

  test "text" do
    text_content = %TextContent{ primaryText: %TextField{text: "primary", type: "PlainText"}}
    assert "primary" == text_content.primaryText.text
  end

end
