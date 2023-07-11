fx_version("adamant")
game("gta5")
lua54("yes")

repository("https://github.com/pablo-1610/openai_fivem")
server_only("yes")

server_scripts({"src/enums/*.lua", "src/*.lua", "src/services/*.lua"})

server_exports({"isBusy", "doChatCompletion"})
