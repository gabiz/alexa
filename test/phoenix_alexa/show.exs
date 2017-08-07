defmodule PhoenixAlexa.ShowTest do
  use ExUnit.Case
  use PhoenixAlexa.Controller, :post
  alias PhoenixAlexa.Response
  alias PhoenixAlexa.Directives.{BodyTemplate2,Hint}
  alias PhoenixAlexa.Objects.{Image,TextField,TextContent}

  test "Put hint directive" do
    response = %Response{}
      |> put_directive(%Hint{ hint: %{text: "search for blue cheese"}})
    assert response.version == "1.0"
  end


  test "Put body template directive" do
    backround_image = %Image{}
          |> Image.set_description("show background")
          |> Image.add_source("https://www.gannett-cdn.com/-mm-/56cefca4e7d49745c87e93f1df10ae25554a839c/r=540/https/videos.usatoday.net/Brightcove3/29906170001/201705/2534/29906170001_5427255531001_5427244397001-vs.jpg")
    regular_image = %Image{}
        |> Image.set_description("asdf")
        |> Image.add_source("http://www.asdf.com/89asdf.gif")

    template = %BodyTemplate2{}
        |> BodyTemplate2.set_background_image(backround_image)
        |> BodyTemplate2.set_image(regular_image)
        |> BodyTemplate2.set_token("asdf")
        |> BodyTemplate2.set_title("another title")
        |> BodyTemplate2.set_text_content(%TextContent{ primaryText: %TextField{text: "primary", type: "PlainText"}})
        |> BodyTemplate2.hide_back_button()

    response = %Response{}
      |> remove_should_end_session
      |> put_directive(template)

    IO.puts response |> Poison.encode!(pretty: true)
    [returned_template = %BodyTemplate2{}] = response.response.directives
    assert returned_template.template.backButton == "HIDDEN"
    assert returned_template.template.backgroundImage.contentDescription == "show background"
    assert response.version == "1.0"
  end




end
