defmodule PhoenixAlexa.Response do
  alias PhoenixAlexa.{Response, TextOutputSpeech, SsmlOutputSpeech}
  alias PhoenixAlexa.{SimpleCard, StandardCard, LinkAccountCard}
  defstruct version: "1.0",
            sessionAttributes: %{},
            response: %{
              shouldEndSession: false
            }

  # def session_attributes(response) do
  #   response[:sessionAttributes]
  # end

  def set_session_attributes(response, sessionAttributes) do
    # response = response || %{}
    # Map.put(response, :sessionAttributes, sessionAttributes)
    %Response{response | sessionAttributes: sessionAttributes}
  end

  def set_output_speech(response, %TextOutputSpeech{} = outputspeech) do
    %Response{response | response: (response.response |> Map.put(:outputSpeech, outputspeech))}
  end
  def set_output_speech(response, %SsmlOutputSpeech{} = outputspeech) do
    %Response{response | response: (response.response |> Map.put(:outputSpeech, outputspeech))}
  end

  def set_card(response, %SimpleCard{} = card) do
    %Response{response | response: (response.response |> Map.put(:card, card))}
  end
  def set_card(response, %StandardCard{} = card) do
    %Response{response | response: (response.response |> Map.put(:card, card))}
  end
  def set_card(response, %LinkAccountCard{} = card) do
    %Response{response | response: (response.response |> Map.put(:card, card))}
  end

  def set_reprompt(response, %TextOutputSpeech{} = outputspeech) do
    %Response{response | response: (response.response |> Map.put(:reprompt, %{outputSpeech: outputspeech}))}
  end
  def set_reprompt(response, %SsmlOutputSpeech{} = outputspeech) do
    %Response{response | response: (response.response |> Map.put(:reprompt, %{outputSpeech: outputspeech}))}
  end

  def set_should_end_session(response, shouldEndSession) do
    %Response{response | response: %{response.response | shouldEndSession: shouldEndSession}}
  end

  # Card helpers

  def set_title(%SimpleCard{} = card, title) do
    SimpleCard.set_title(card, title)
  end
  def set_title(%StandardCard{} = card, title) do
    StandardCard.set_title(card, title)
  end
  def set_title(%LinkAccountCard{} = card, title) do
    LinkAccountCard.set_title(card, title)
  end

  def set_content(%SimpleCard{} = card, content) do
    SimpleCard.set_content(card, content)
  end
  def set_content(%LinkAccountCard{} = card, content) do
    LinkAccountCard.set_content(card, content)
  end

  def set_text(%StandardCard{} = card, text) do
    StandardCard.set_text(card, text)
  end

  def set_small_image_url(%StandardCard{} = card, image_url) do
    StandardCard.set_small_image_url(card, image_url)
  end

  def set_large_image_url(%StandardCard{} = card, image_url) do
    StandardCard.set_large_image_url(card, image_url)
  end

  #Audio Helpers

  #Audio helpers
  def put_stop_audio_directive(response) do
    directive = %{
      :type => "AudioPlayer.Stop"
     }
     put_directive(response,directive)
  end
  def put_replace_audio_directive(response,url,token,offset) do
    directive = %{
      :type => "AudioPlayer.Play",
      :playBehavior => "REPLACE_ALL",
      :audioItem => %{
        :stream => %{
            :url => url,
            :token => token,
            :offsetInMilliseconds => offset
        }
      }
     }
     put_directive(response,directive)
  end
  def put_enqueue_audio_directive(response,url,token,previous_token,offset) do
    directive = %{
      :type => "AudioPlayer.Play",
      :playBehavior => "ENQUEUE",
      :audioItem => %{
        :stream => %{
            :url => url,
            :token => token,
            :offsetInMilliseconds => offset,
            :expectedPreviousToken => previous_token
        }
      }
     }
     put_directive(response,directive)
  end

  def put_directive(response,directive) do
    case response.response do
      %{:directives => to_append} ->
        %Response{response | response: (response.response
        |> Map.put(:directives, [directive] ++ to_append))}
      _ ->
        %Response{response | response: (response.response
          |> Map.put(:directives, [directive] ))}
    end
  end


  def put_video_app_launch_directive(response,url,title,subtitle) do
    directive = %{
      :type => "VideoApp.Launch",
      :videoItem => %{
        :source => url,
        :metadata => %{
            :title => title,
            :subtitle => subtitle
        }
      }
     }
     put_directive(response,directive)
  end

  def remove_should_end_session(response) do
    response |> Map.put( :response , %{})
  end


end
