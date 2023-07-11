local OpenAI = {busy = false}

local function validateApiKeyThroughBasicRequest()
    local p <const> = promise.new()
    PerformHttpRequest("https://api.openai.com/v1/models", function(code)
        p:resolve(code == 200)
    end, ERequestMethod.GET, nil, OpenAI.getRequestHeader())
    return Citizen.Await(p)
end

function OpenAI.getRequestHeader()
    return {
        ["Content-Type"] = "application/json",
        ["Authorization"] = ("Bearer %s"):format(OpenAI.apiKey),
        ["User-Agent"] = "OpenAI-Lua/1.0.0"
    }
end

--- @param str string
function OpenAI.trace(str, isSevere)
    print(("[^5OpenAI^7] %s%s^7"):format(isSevere and "(^1!^7) " or "", str))
end

CreateThread(function()
    OpenAI.apiKey = GetConvar("openai_api_key", "")
    if (OpenAI.apiKey == "") then
        return OpenAI.trace("No API key defined, you need to define your OpenAI API key with the ^9openai_api_key ^7server convar (^4https://platform.openai.com/account/api-keys^7).", true)
    end
    if (not validateApiKeyThroughBasicRequest()) then
        return OpenAI.trace("Invalid API key, please check your OpenAI API key ! (^4https://platform.openai.com/account/api-keys^7).", true)
    end
    OpenAI.trace("OpenAI API key ^2validated^7 !")
end)

-- Exports
function isBusy()
    return OpenAI.busy
end

_G.OpenAI = OpenAI
