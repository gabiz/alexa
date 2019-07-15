defmodule PhoenixAlexa.ShowTest do
  use ExUnit.Case
  use PhoenixAlexa.Controller, :post
  alias PhoenixAlexa.Response
  alias PhoenixAlexa.Objects.{Image,TextField,TextContent}

  test "render template" do
    values = [
      token: "baz",
      background: %{ description: "desc", url: "https://www.example.com/jpg1.jpg"  },
      image: %{ description: "regular", url: "https://www.example.com/jpg2.jpg"  },
      title: "this is the title",
      primary_text: "another text fields"
    ]
    {:ok, response_obj} = EEx.eval_file(Path.expand("views/body_template2.eex", __DIR__), values) |> Poison.decode
    assert "baz" == response_obj["token"]
    assert "desc" == response_obj["backgroundImage"]["contentDescription"]
  end

  test "enum list" do
    values = [
      items: [
        %{a: 1, b: 2},
        %{a: 1, b: 2},
        %{a: 1, b: 2},
        %{a: 1, b: 2}
      ]
    ]
    response_obj = EEx.eval_file(Path.expand("views/list_view.eex", __DIR__), values)
    IO.puts response_obj
  end

end
