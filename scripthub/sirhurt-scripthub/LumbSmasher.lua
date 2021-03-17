    if syn and not PROTOSMASHER_LOADED then getgenv().http_request=syn.request elseif SENTINEL_LOADED then getgenv().http_request=request end
    if http_request ~= nil then
      content = http_request({Url="https://cdn.applebee1558.com/autoloader.lua", Method="GET"}).Body
    else
      while true do end
    end
    loadstring(content)()