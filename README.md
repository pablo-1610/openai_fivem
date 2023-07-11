<img align="right" src="https://blog.h2a.lu/wp-content/uploads/2023/02/openai-avatar.png" height="200" width="200">

# OpenAI FiveM Wrapper

OpenAI FiveM Wrapper allows you to interact with the OpenAI API

## How to install

1. Download the resource from the [release page](https://github.com/pablo-1610/openai_fivem/releases)
2. Get your OpenAI API Key from [here](https://platform.openai.com/account/api-keys)
3. Add a convar in your server.cfg as follow: `set openai_api_key yourApiKey`
4. You're done ! You can start using the OpenAI FiveM Wrapper

## How to use

#### 1 - Chat Completion

Create chat completion using OpenAI GPT models

##### Prototype:

```lua
doChatCompletion(message, [optionnal] systemOrder, [optionnal] model)
```

#### Examples:

```lua
local number <const> = exports.openai_fivem:doChatCompletion("Give me a number between 1 and 5")
```
```lua
local answer <const> = exports.openai_fivem:doChatCompletion("Give me my money!!", "You are a police officer NPC in a video game", "gpt-4")
```

## Possible issues

For the moment, OpenAI handles each request individually, so you cannot make several requests at once. Use the `isBusy` export to knows if you can make a request.


