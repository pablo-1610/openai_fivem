local function createDataPayload(userMessage, systemOrder, modelName)
    local data <const> = { model = modelName, messages = {{role = "user", content = userMessage}}, }
    if (systemOrder) then
        table.insert(data.messages, {role = "system", content = systemOrder})
    end
    return json.encode(data)
end

--- @param userMessage string The user message
--- @param systemOrder string The system order
--- @param modelName string The OpenAI model to use
function doChatCompletion(userMessage, systemOrder, modelName)
    if (OpenAI.busy) then
        return error("OpenAI is busy, please wait for the previous request to finish. Use the isBusy export to avoid this error.")
    end
    if (not userMessage or userMessage == "") then
        return error("No user message provided !")
    end
    modelName = modelName or EAiChatModel.GPT_Turbo3_5
    OpenAI.busy = true
    local p <const> = promise.new()
    PerformHttpRequest(EApiEndpoint.Completions, function(code, data, _, error)
        if (code ~= 200) then
            OpenAI.trace(("An error occured while requesting the OpenAI API: %s"):format(error))
            return p:resolve(nil)
        end
        data = json.decode(data)
        p:resolve(data.choices[1].message.content)
    end, ERequestMethod.POST, createDataPayload(userMessage, systemOrder, modelName), OpenAI.getRequestHeader())
    local result <const> = Citizen.Await(p)
    OpenAI.busy = false
    return result
end
