defmodule PhoenixAlexa.RequestTest do
  use ExUnit.Case

  alias PhoenixAlexa.{Request, Session, IntentRequest}

  test "overall request" do
    json = """
{
  "session": {
    "sessionId": "SessionId.80ef8951-172e-4f02-ace8-a7ec847e2d9f",
    "application": {
      "applicationId": "amzn1.echo-sdk-ams.app.05dcb1a4-cb45-46c5-a30e-bb3033a0770a"
    },
    "attributes": {},
    "user": {
      "userId": "amzn1.ask.account.AFP3ZWPOS2BGJR7OWJZ3DHPKMOMNWY4AY66FUR7ILBWANIHQN73QH3G5PC2FJVGDIDA7MY54GGNRGM4SVPKTT3K53SLI232MEFI77TZN7W6LISNFZTTFDSPCLX6OB4ISJDVJB6QZO3XC74US6CH5DQXYCVOODNTUFNI5JNSUWSBDVMWB7JXPVX43P4EUIMHTPZHNRHZDUDENZVI"
    },
    "new": false
  },
  "request": {
    "type": "LaunchRequest",
    "requestId": "EdwRequestId.27142539-8af4-430c-8f22-411cfab269bd",
    "timestamp": "2016-07-07T00:45:08Z"
  },
  "context": {
    "System": {
      "user": {
        "userId": "abcd",
        "permissions": {
          "consentToken": "12345"
        }
      },
      "device": {
        "deviceId": "xyz"
      }
    }
  },
  "version": "1.0"
}
    """
    overall_request = Poison.decode!(json, as: %Request{})
    assert overall_request.request.type == "LaunchRequest"
    assert overall_request.session.sessionId == "SessionId.80ef8951-172e-4f02-ace8-a7ec847e2d9f"
    assert Map.get(overall_request.context, :System).user.userId == "abcd"
    assert Map.get(overall_request.context, :System).user.permissions.consentToken == "12345"
    assert Map.get(overall_request.context, :System).device.deviceId == "xyz"
  end

  test "session" do
    json_session = """
{
  "new": false,
  "sessionId": "amzn1.echo-api.session.0000000-0000-0000-0000-00000000000",
  "application": {
    "applicationId": "amzn1.echo-sdk-ams.app.000000-d0ed-0000-ad00-000000d00ebe"
  },
  "attributes": {
    "supportedHoroscopePeriods": {
      "daily": true,
      "weekly": false,
      "monthly": false
    }
  },
  "user": {
    "userId": "amzn1.account.AM3B00000000000000000000000"
  }
}
""" 
    session = Poison.decode!(json_session, as: %Session{})

    assert session.new == false
    assert session.sessionId == "amzn1.echo-api.session.0000000-0000-0000-0000-00000000000"
    assert session.application.applicationId == "amzn1.echo-sdk-ams.app.000000-d0ed-0000-ad00-000000d00ebe"
    assert session.attributes == %{
        "supportedHoroscopePeriods" => %{
          "daily" => true,
          "weekly" => false,
          "monthly" => false
        }
      }
    assert session.user.userId == "amzn1.account.AM3B00000000000000000000000"
  end

  test "request" do
    json_request = """
{
  "type": "IntentRequest",
  "requestId": "amzn1.echo-api.request.0000000-0000-0000-0000-00000000000",
  "timestamp": "2015-05-13T12:34:56Z",
  "intent": {
    "name": "GetZodiacHoroscopeIntent",
    "slots": {
      "ZodiacSign": {
        "name": "ZodiacSign",
        "value": "virgo"
      }
    }
  }
}
"""

    request = Poison.decode!(json_request, as: %IntentRequest{})

    assert request.type == "IntentRequest"
    assert request.requestId == "amzn1.echo-api.request.0000000-0000-0000-0000-00000000000"
    assert request.timestamp == "2015-05-13T12:34:56Z"
    assert request.intent.name == "GetZodiacHoroscopeIntent"
    assert request.intent.slots["ZodiacSign"]["name"] == "ZodiacSign"
    assert request.intent.slots["ZodiacSign"]["value"] == "virgo"
  end

end



# {
#   "version": "1.0",
#   "session": {
#     "new": false,
#     "sessionId": "amzn1.echo-api.session.0000000-0000-0000-0000-00000000000",
#     "application": {
#       "applicationId": "amzn1.echo-sdk-ams.app.000000-d0ed-0000-ad00-000000d00ebe"
#     },
#     "attributes": {
#       "supportedHoroscopePeriods": {
#         "daily": true,
#         "weekly": false,
#         "monthly": false
#       }
#     },
#     "user": {
#       "userId": "amzn1.account.AM3B00000000000000000000000"
#     }
#   },
#   "request": {
    # "type": "IntentRequest",
    # "requestId": " amzn1.echo-api.request.0000000-0000-0000-0000-00000000000",
    # "timestamp": "2015-05-13T12:34:56Z",
    # "intent": {
    #   "name": "GetZodiacHoroscopeIntent",
    #   "slots": {
    #     "ZodiacSign": {
    #       "name": "ZodiacSign",
    #       "value": "virgo"
    #     }
    #   }
    # }
#   }
# }
