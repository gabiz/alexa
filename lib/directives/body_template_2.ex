defmodule PhoenixAlexa.Directives.BodyTemplate2 do
  alias PhoenixAlexa.Directives.{BodyTemplate2}
  alias PhoenixAlexa.Objects.{Image,TextContent}

  defstruct type: "Display.RenderTemplate",
            template: %{
                type: "BodyTemplate2",
                token: nil,
                backButton: "VISIBLE",
                image: %Image{},
                title: "",
                textContent: %TextContent{}
            }

  defp merge_map(body_template, map) do
     %BodyTemplate2{
       template: Map.merge(body_template.template,map)
     }
  end

  def hide_back_button(body_template) do
    body_template |> merge_map( %{ backButton: "HIDDEN" })
  end

  def set_background_image(body_template, value = %Image{}) do
    body_template |> merge_map( %{ backgroundImage: value })
  end

  def set_image(body_template, value = %Image{}) do
    body_template |> merge_map( %{ image: value })
  end

  def set_token(body_template, value) do
    body_template |> merge_map( %{ token: value })
  end

  def set_title(body_template,value) do
    body_template |> merge_map( %{ title: value })
  end

  def set_text_content(body_template, value) do
    body_template |> merge_map( %{ textContent: value })
  end

end
