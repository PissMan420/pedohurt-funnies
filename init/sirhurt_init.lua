--- grabbed 4/9/2021
--- pretty useless now, as they are starting to do things on the C side (ugh) 
--- but, you can see how utterly RETARDED and STUPID and INCOMPETENT Icepools and Aero were in creating this, I mean, heck, somethings still apply.
--- s/o FxE btw
--- init below

--  VERIFY HASH F9AE17CF3FFA9F586CF67CB04A185C9C

-- TODO: set script object to this in the actual exploit
--getfenv().script = getfenv(Instance.new("RemoteEvent").FireServer).script;

local getgenv = getgenv
local getfenv = getfenv
local setfenv = setfenv

local newcclosure = newcclosure or function(...)
    return ...
end

getgenv().newcclosure = newcclosure(function(...) return newcclosure(...) end)


--TODO: gay
--[[if (game:GetService("CoreGui"):FindFirstChild("RobloxLoadingGui")) then
    while (#game:GetService("CoreGui").RobloxLoadingGui:GetChildren() > 0) do
       wait(2) ch
    end
end]]

local setscript = setscript or function() warn("bad") end

function secure_call(func, newScript, ...)
    local previousScript, 
        previousIdentity = script, getthreadidentity()
    
    setthreadidentity(2) -- basescript identity
    setscript(newScript) -- basescript to "fake"
    
    local success, results = pcall(func, ...)
    
    setthreadidentity(previousIdentity)
    setscript(previousScript)
    
    if success then 
        return results
    else
        error(results)
    end
end

getgenv().setscript = nil;

getgenv().Sirhurt = 4
getgenv().syn = {
    ['crypt'] = {
        ['decrypt'] = function(...) getgenv().SIRHURT_NOTIFICATION({Title = "INCOMPATABLE", Body = "syn.crypt.decrypt is not supported on SirHurt V4."}) end,
        ['hash'] = function(...) getgenv().SIRHURT_NOTIFICATION({Title = "INCOMPATABLE", Body = "syn.crypt.hash is not supported on SirHurt V4."}) end,
        ['encrypt'] = function(...) getgenv().SIRHURT_NOTIFICATION({Title = "INCOMPATABLE", Body = "syn.crypt.encrypt is not supported on SirHurt V4."}) end
    },
    ['secrun'] = function(...) getgenv().SIRHURT_NOTIFICATION({Title = "INCOMPATABLE", Body = "syn.is_cached is not supported on SirHurt V4."}) end,
    ['is_beta'] = function() return false end,
    ['secure_call'] = secure_call,
    ['cache_replace'] = function(...) getgenv().SIRHURT_NOTIFICATION({Title = "INCOMPATABLE", Body = "syn.cache_replace is not supported on SirHurt V4."}) end,
    ['get_thread_identity'] = get_thread_identity,
    ['request'] = http_request,
    ['protect_gui'] = function(a) if type(a) == "userdata" and a:IsA("ScreenGui") then pcall(function() a.Parent = get_hidden_gui() end) end end,
    ['run_secure_lua'] = function(...) getgenv().SIRHURT_NOTIFICATION({Title = "INCOMPATABLE", Body = "syn.run_secure_lua is not supported on SirHurt V4."}) end,
    ['cache_invalidate'] = function(...) getgenv().SIRHURT_NOTIFICATION({Title = "INCOMPATABLE", Body = "syn.cache_invalidate is not supported on SirHurt V4."}) end,
    ['queue_on_teleport'] = queue_on_teleport,
    ['is_cached'] = function(...) getgenv().SIRHURT_NOTIFICATION({Title = "INCOMPATABLE", Body = "syn.is_cached is not supported on SirHurt V4."}) end,
    ['set_thread_identity'] = set_thread_identity,
    ['write_clipboard'] = setclipboard,
    ['run_secure_function'] = function(...) getgenv().SIRHURT_NOTIFICATION({Title = "INCOMPATABLE", Body = "syn.run_secure_function is not supported on SirHurt V4."}) end,
    ['crypt'] = {
        ['encrypt'] = function() end,
        ['lz4'] = {
            ['compress'] = function() end
        },
        ['custom'] = {
            ['decrypt'] = function() end,
            ['hash'] = function(...) getgenv().SIRHURT_NOTIFICATION({Title = "INCOMPATABLE", Body = "syn.custom.hash is not supported on SirHurt V4."}) end,
            ['encrypt'] = function(...) getgenv().SIRHURT_NOTIFICATION({Title = "INCOMPATABLE", Body = "syn.custom.encrypt is not supported on SirHurt V4."}) end
        },
        ['base64'] = {
            ['encode'] = BASE64_ENCODE, 
            ['decode'] = BASE64_DECODE
        },
        ['decrypt'] = function() end,
        ['derive'] = function() end,
        ['random'] = function() end,
        ['hash'] = function() end
    },
    ['websocket'] = {
        ['connect'] = function() end
    },
    ['unprotect_gui'] = function(a) end,
    ['create_secure_function'] = function(...) getgenv().SIRHURT_NOTIFICATION({Title = "INCOMPATABLE", Body = "syn.create_secure_function is not supported on SirHurt V4."}) end,
    ['sirhurt_syn'] = true;
}

local printconsoleinternal = printconsole
local printconsole = function(...)
    for _, v in next, ... do
        printconsoleinternal(tostring(v))
    end
end
getgenv().printconsole = printconsole

local CoreGui = Game:GetService("CoreGui")
local CorePackages = Game:GetService("CorePackages")

local internal = getloadedmodules -- save original glm for later use
getgenv().getloadedmodules = newcclosure(function()
    local result = {}

    -- filter out roblox core modules
    for _, module in pairs(internal()) do
        if not module:IsDescendantOf(CoreGui) and 
            not module:IsDescendantOf(CorePackages) then
            table.insert(result, module)
        end
    end

    return result
end)

-- internal functions
local httpgetinternal = httpgetinternal
local httppostinternal = httppostinternal 
local teleportcbinternal = teleportcbinternal
getgenv().httpgetinternal = nil
getgenv().httppostinternal = nil
getgenv().teleportcbinternal = nil

--allow scripts to run
--getgenv().sethiddenproperty = sethiddenproperty or newcclosure(function() end)
--getgenv().gethiddenproperty = gethiddenproperty or newcclosure(function() return "" end)

-- @author: Aero
-- @info: I'm ashamed to be the creator of this code: it's disgusting.

if updatehiddenproperty then
do
    local getset = updatehiddenproperty
    local ghproperites = fetchhiddenproperties

     getgenv().gethiddenproperty = newcclosure(function(instance, what)
        return getset(instance, what, nil, true)
    end)    
    
     getgenv().sethiddenproperty = newcclosure(function(instance, what, value)
        return getset(instance, what, value, false)
    end)
    
    if fetchhiddenproperties then
        getgenv().gethiddenproperties = newcclosure(function(instance)
            local properties = ghproperites(instance);
            local storage = {}
            
            for i = 1, #properties do
                local err, b = pcall(function()
                    storage[properties[i]] = gethiddenproperty(instance, properties[i]);
                end)
                
                if not err then
                    storage[properties[i]] = "";
                end
            end
            
            return storage;
        end)
    end

    getgenv().setsimulationradius = setsimulationradius or newcclosure(function(a, b) 
        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", a) 
        
        if b then 
            sethiddenproperty(game.Players.LocalPlayer, "MaxSimulationRadius", b)
        end 
    end)
    
    getgenv().fetchhiddenproperties = nil
    getgenv().updatehiddenproperty = nil
end
end

-- debug functions
local notsupported = newcclosure(function()
    error("this function is not currently supported by SirHurt")
end)

local setreadonly = setreadonly

local getrawmetatable = getrawmetatable
local setrawmetatable = setrawmetatable
local getupvalues = getupvalues
local getupvalue = getupvalue
local setupvalue = setupvalue
local getgc = getgc
local getreg = getreg
local getlocal = getlocal
local getconstants = getconstants
local setconstant = setconstant
local getinfo = getinfo
local upvalueid = upvalueid
local upvaluejoin = upvaluejoin
local getstack = getstack
local setstack = setstack
local getproto = getproto
local getprotos = getprotos
local setproto = setproto

-- @author: Aero
local function firesignal(signal, ...)
    local connections = getconnections(signal)

    for _, connection in next, connections do    
        pcall(connection.Function, ...)
    end
end

getgenv().firesignal = firesignal

local rdebug = getrenv().debug
local debug = {}

for i, v in next, rdebug do
    debug[i] = v
end

debug.getmetatable = getrawmetatable or notsupported
debug.setmetatable = setrawmetatable or notsupported
debug.getupvalues = getupvalues or notsupported
debug.getupvalue = getupvalue or notsupported
debug.setupvalue = setupvalue or notsupported
debug.getproto = getproto or notsupported
debug.getprotos = getprotos or notsupported
debug.setproto = setproto or notsupported
debug.getgc = getgc or notsupported
debug.getregistry = getreg or notsupported
debug.getfenv = getfenv or notsupported
debug.setfenv = setfenv or notsupported
debug.getconstants = getconstants or notsupported
debug.setconstant = setconstant or notsupported
debug.upvalueid = upvalueid or notsupported
debug.upvaluejoin = upvaluejoin or notsupported
debug.getinfo = getinfo or notsupported
debug.getstack = getstack or notsupported
debug.setstack = setstack or notsupported
debug.getlocal = getlocal or notsupported
debug.getlocals = getlocals or notsupported
debug.setupvaluename = setupvaluename or notsupported
debug.validlevel = validlevel or notsupported

setreadonly(debug, true)
getgenv().debug = debug

--[[local rbit32 = getrenv().bit32
local bit32 = {}

for i, v in next, rbit32 do
    bit32[i] = v
end

function bit32.badd(a, b)
    return a + b
end

function bit32.bsub(a, b)
    return a - b
end

function bit32.bmul(a, b)
    return a * b
end

function bit32.bdiv(a, b)
    return a / b
end

function bit32.tobit(x)
    x = x % (2^32)
    if x >= 0x80000000 then x = x - (2^32) end
    return x
end

function bit32.bswap(x)
    x = x % (2^32)
    local a = bit32.band(x, 0xff);
    x = bit32.rshift(x, 8)
    local b = bit32.band(x, 0xff);
    x = bit32.rshift(x, 8)
    local c = bit32.band(x, 0xff);
    x = bit32.rshift(x, 8)
    local d = bit32.band(x, 0xff)
    return bit32.tobit(bit32.lshift(bit32.lshift(bit32.lshift(a, 8) + b, 8) + c, 8) + d)
end

function bit32.tohex(x, n)
    n = n or 8
    local up
    if n <= 0 then
        if n == 0 then return '' end
        up = true
        n = - n
    end
    x = x % (2^32)
    x = bit32.band(x, 16^n-1)
    return ('%0'..n..(up and 'X' or 'x')):format(x)
end

setreadonly(bit32, isreadonly(rbit32))
getgenv().bit32 = bit32
getgenv().bit = bit32
]]

getgenv().make_writeable = newcclosure(function(t)
    return setreadonly(t, false)
end)

getgenv().make_readonly = newcclosure(function(t)
    return setreadonly(t, true)
end)

local mousemove = mousemove

local virtualInputManager = game:GetService("VirtualInputManager")
local userInputService = game:GetService("UserInputService")

getgenv().mouse1press = mouse1press or newcclosure(function(x, y)
    x = x or userInputService:GetMouseLocation().X
    y = y or userInputService:GetMouseLocation().Y
    virtualInputManager:SendMouseButtonEvent(x, y, Enum.UserInputType.MouseButton1, true, nil)
end)

getgenv().mouse1release = mouse1release or newcclosure(function(x, y)
    x = x or userInputService:GetMouseLocation().X
    y = y or userInputService:GetMouseLocation().Y
    virtualInputManager:SendMouseButtonEvent(x, y, Enum.UserInputType.MouseButton1, false, nil)
end)

getgenv().mouse1click = newcclosure(function(delay, x, y)
    delay = delay ~= 0 and delay or 0
    mouse1press(x, y)
    wait(delay)
    mouse1release(x, y)
end)

getgenv().mouse2press = mouse2press or newcclosure(function(x, y)
    x = x or userInputService:GetMouseLocation().X
    y = y or userInputService:GetMouseLocation().Y
    assert(type(x) == "number", "x coordinate must be a number")
    assert(type(y) == "number", "y coordinate must be a number")
    virtualInputManager:SendMouseButtonEvent(x, y, Enum.UserInputType.MouseButton2, true, nil)
end)

getgenv().mouse2release = mouse2release or newcclosure(function(x, y)
    x = x or userInputService:GetMouseLocation().X
    y = y or userInputService:GetMouseLocation().Y
    assert(type(x) == "number", "x coordinate must be a number")
    assert(type(y) == "number", "y coordinate must be a number")
    virtualInputManager:SendMouseButtonEvent(x, y, Enum.UserInputType.MouseButton2, false, nil)
end)

getgenv().mouse2click = newcclosure(function(delay, x, y)
    delay = delay ~= 0 and delay or 0
    mouse2press(x, y)
    wait(delay)
    mouse2release(x, y)
end)

getgenv().mousescroll = newcclosure(function(amount, x, y)
    if (type(amount) == "boolean") then	amount = amount and 120 or -120	end
    assert(type(amount) == "number", "amount must be a boolean or a number")

    x = x or userInputService:GetMouseLocation().X
    y = y or userInputService:GetMouseLocation().Y
    for i = 1, math.abs(math.floor(amount / 120)) do
        virtualInputManager:SendMouseWheelEvent(x, y, amount >= 0, nil)
        wait()
    end
end)

local set_syn_emulation = set_syn_emulation or function() end
getgenv().set_syn_emulation = nil

getgenv().synapse_emulator = newcclosure(function()
backup_env = {}

set_syn_emulation();

for i,v in pairs(getgenv()) do
    
    if type(v) == "function" and is_synapse_function(v) then
        backup_env[i] = v 

        if i ~= "is_synapse_function" and i ~= "getgenv" and i ~= "newcclosure" then
            getgenv()[i] = nil
        end
    end

    if (type(v) == "string" and i ~= "debug") then
        backup_env[i] = v
        getgenv()[i] = nil
    end

    if (type(v) == "number") then
        backup_env[i] = v
        getgenv()[i] = nil
     end

end

for i,v in pairs(_G) do
_G[i] = nil
end

for i,v in pairs(shared) do
shared[i] = nil
end

getgenv()['syn_websocket_send'] = newcclosure(function() end)
getgenv()['firesignal'] = backup_env['firesignal']
getgenv()['makefolder'] = backup_env['makefolder']
getgenv()['syn_io_append'] = backup_env['appendfile']
getgenv()['is_protosmasher_caller'] = backup_env['is_protosmasher_caller']
getgenv()['clonefunction'] = newcclosure(function() end)
getgenv()['setrawmetatable'] = backup_env['setrawmetatable']
getgenv()['syn_mouse2press'] = backup_env['mouse2press']
getgenv()['syn_io_delfolder'] = backup_env['deletefolder']
getgenv()['getrawmetatable'] = backup_env['getrawmetatable']
getgenv()['getinstancefromstate'] = newcclosure(function() end)
getgenv()['syn_io_makefolder'] = backup_env['makefolder']
getgenv()['gethiddenprop'] = backup_env['gethiddenproperty']
getgenv()['setfflag'] = backup_env['setfflag']
getgenv()['gethiddenprops'] = backup_env['gethiddenproperties']
getgenv()['getcallingscript'] = backup_env['getcallingscript']
getgenv()['sethiddenprop'] = backup_env['sethiddenproperty']
getgenv()['getrenv'] = backup_env['getrenv']
getgenv()['getstates'] = newcclosure(function() end)
getgenv()['get_instances'] = newcclosure(function() end)
getgenv()['gethiddenproperties'] = backup_env['gethiddenproperties']
getgenv()['getspecialinfo'] = backup_env['getspecialinfo']
getgenv()['isluau'] = backup_env['isluau']
getgenv()['decompile'] = backup_env['decompile']
getgenv()['loadstring'] = backup_env['loadstring']
getgenv()['getprotos'] = backup_env['getprotos']
getgenv()['syn_io_isfolder'] = backup_env['isfolder']
getgenv()['hookfunction'] = backup_env['hookfunction']
getgenv()['isfile'] = backup_env['isfile']
getgenv()['getproto'] = backup_env['getproto']
getgenv()['isrbxactive'] = backup_env['isrbxactive']
getgenv()['rconsoleinfo'] = newcclosure(function() end)
getgenv()['make_readonly'] = backup_env['make_readonly']
getgenv()['getstack'] = backup_env['getstack']
getgenv()['rconsolename'] = newcclosure(function() end)
getgenv()['unlockmodulescript'] = backup_env['unlockmodulescript']
getgenv()['getupvalue'] = backup_env['getupvalue']
getgenv()['syn_getgc'] = backup_env['getgc']
getgenv()['syn_mouse2release'] = backup_env['mouse2release']
getgenv()['setproto'] = backup_env['setproto']
getgenv()['mouse1click'] = backup_env['mouse1click']
getgenv()['syn_io_read'] = backup_env['readfile']
getgenv()['setupvalue'] = backup_env['setupvalue']
getgenv()['syn_io_delfile'] = newcclosure(function() end)
getgenv()['gethiddenproperty'] = backup_env['gethiddenproperty']
getgenv()['identifyexecutor'] = backup_env['identifyexecutor']
getgenv()['getscripts'] = backup_env['getscripts']
getgenv()['rconsoleerr'] = newcclosure(function() end)
getgenv()['dumpstring'] = newcclosure(function() end)
getgenv()['keypress'] = backup_env['keypress']
getgenv()['syn_mousescroll'] = newcclosure(function() end)
getgenv()['syn_crypt_derive'] = newcclosure(function() end)
getgenv()['syn_mouse1click'] = backup_env['mouse1press']
getgenv()['get_scripts'] = backup_env['getscripts']
getgenv()['rconsoleclear'] = newcclosure(function() end)
getgenv()['getlocals'] = newcclosure(function() end)
getgenv()['is_redirection_enabled'] = newcclosure(function() end)
getgenv()['syn_context_set'] = backup_env['getthreadidentity']
getgenv()['syn_keyrelease'] = backup_env['keyrelease']
getgenv()['syn_io_listdir'] = newcclosure(function() end)
getgenv()['isreadonly'] = backup_env['isreadonly']
getgenv()['mouse2click'] = backup_env['mouse2click']
getgenv()['getinfo'] = backup_env['getinfo']
getgenv()['sethiddenproperty'] = backup_env['sethiddenproperty']
getgenv()['writefile'] = backup_env['writefile']
getgenv()['loadfile'] = backup_env['loadfile']
getgenv()['setlocal'] = newcclosure(function() end)
getgenv()['getconstant'] = backup_env['getconstant']
getgenv()['syn_setfflag'] = backup_env['setfflag']
getgenv()['getproperties'] = newcclosure(function() end)
getgenv()['getprops'] = newcclosure(function() end)
getgenv()['require'] = backup_env['require']
getgenv()['setconstant'] = backup_env['setconstant']
getgenv()['is_synapse_function'] = backup_env['is_synapse_function']
getgenv()['getscriptclosure'] = backup_env['getscriptclosure']
getgenv()['get_nil_instances'] = backup_env['get_nil_instances']
getgenv()['getconnections'] = backup_env['getconnections']
getgenv()['checkcaller'] = backup_env['checkcaller']
getgenv()['getnilinstances'] = backup_env['getnilinstances']
getgenv()['setclipboard'] = backup_env['setclipboard']
getgenv()['printconsole'] = backup_env['printconsole']
getgenv()['setreadonly'] = backup_env['setreadonly']
getgenv()['setscriptable'] = newcclosure(function() end)
getgenv()['setsimulationradius'] = newcclosure(function(a) return getgenv()['sethiddenproperty'](game.Players.LocalPlayer, "SimulationRadius", a) end)
getgenv()['syn_getsenv'] = backup_env['getsenv']
getgenv()['syn_io_isfile'] = backup_env['isfile']
getgenv()['syn_crypt_encrypt'] = newcclosure(function() end)
getgenv()['getlocal'] = newcclosure(function() end)
getgenv()['firetouchinterest'] = backup_env['firetouchinterest']
getgenv()['syn_mouse1press'] = backup_env['mouse1press']
getgenv()['syn_newcclosure'] = backup_env['newcclosure']
getgenv()['validfgwindow'] = backup_env['validfgwindow']
getgenv()['saveinstance'] = backup_env['saveinstance']
getgenv()['getinstances'] = newcclosure(function() end)
getgenv()['getconstants'] = backup_env['getconstants']
getgenv()['getloadedmodules'] = backup_env['getloadedmodules']
getgenv()['rconsoleprint'] = newcclosure(function() end)
getgenv()['readbinarystring'] = newcclosure(function() end)
getgenv()['syn_getloadedmodules'] = backup_env['getloadedmodules']
getgenv()['isnetworkowner'] = newcclosure(function() end)
getgenv()['messagebox'] = backup_env['messagebox']
getgenv()['delfile'] = newcclosure(function() end)
getgenv()['mouse1release'] = backup_env['mouse1release']
getgenv()['setnamecallmethod'] = backup_env['setnamecallmethod']
getgenv()['syn_getreg'] = backup_env['getreg']
getgenv()['syn_dumpstring'] = newcclosure(function() end)
getgenv()['get_loaded_modules'] = backup_env['get_loaded_modules']
getgenv()['syn_mousemoverel'] = backup_env['mousemoverel']
getgenv()['readfile'] = backup_env['readfile']
getgenv()['replaceclosure'] = backup_env['replaceclosure']
getgenv()['hookfunc'] = backup_env['hookfunction']
getgenv()['get_calling_script'] = backup_env['getcallingscript']
getgenv()['delfolder'] = backup_env['delfolder']
getgenv()['syn_getcallingscript'] = backup_env['getcallingscript']
getgenv()['keyrelease'] = backup_env['keyrelease']
getgenv()['syn_islclosure'] = backup_env['islclosure']
getgenv()['XPROTECT'] = backup_env['XPROTECT']
getgenv()['appendfile'] = backup_env['appendfile']
getgenv()['isfolder'] = backup_env['isfolder']
getgenv()['listfiles'] = backup_env['listfiles']
getgenv()['getcallstack'] = newcclosure(function() end)
getgenv()['syn_websocket_connect'] = newcclosure(function() end)
getgenv()['syn_crypt_hash'] = newcclosure(function() end)
getgenv()['syn_websocket_close'] = newcclosure(function() end)
getgenv()['is_protosmasher_closure'] = backup_env['is_protosmasher_closure']
getgenv()['syn_checkcaller'] = backup_env['checkcaller']
getgenv()['syn_mouse2click'] = backup_env['mouse2press']
getgenv()['mousemoverel'] = backup_env['mousemoverel']
getgenv()['mousescroll'] = backup_env['mousescroll']
getgenv()['syn_mouse1release'] = backup_env['mouse1release']
getgenv()['mousemoveabs'] = backup_env['mousemoveabs']
getgenv()['islclosure'] = backup_env['islclosure']
getgenv()['rconsolewarn'] = newcclosure(function() end)
getgenv()['getstateenv'] = newcclosure(function() end)
getgenv()['syn_clipboard_set'] = backup_env['setclipboard']
getgenv()['syn_crypt_decrypt'] = newcclosure(function() end)
getgenv()['syn_crypt_b64_encode'] = newcclosure(function() end)
getgenv()['mouse2release'] = backup_env['mouse2release']
getgenv()['mouse2press'] = backup_env['mouse2press']
getgenv()['syn_getmenv'] = newcclosure(function() end)
getgenv()['syn_crypt_b64_decode'] = newcclosure(function() end)
getgenv()['getpropvalue'] = newcclosure(function() end)
getgenv()['syn_getrenv'] = backup_env['getrenv']
getgenv()['syn_getgenv'] = backup_env['getgenv']
getgenv()['mouse1press'] = backup_env['mouse1press']
getgenv()['is_lclosure'] = backup_env['is_lclosure']
getgenv()['getgc'] = backup_env['getgc']
getgenv()['syn_keypress'] = backup_env['keypress']
getgenv()['getpointerfromstate'] = newcclosure(function() end)
getgenv()['getnamecallmethod'] = backup_env['getnamecallmethod']
getgenv()['setfpscap'] = newcclosure(function() end)
getgenv()['syn_decompile'] = backup_env['decompile']
getgenv()['syn_mousemoveabs'] = backup_env['mousemoveabs']
getgenv()['setpropvalue'] = newcclosure(function() end)
getgenv()['rconsoleinputasync'] = newcclosure(function() end)
getgenv()['getsenv'] = backup_env['getsenv']
getgenv()['syn_crypt_random'] = newcclosure(function() end)
getgenv()['fireclickdetector'] = backup_env['fireclickdetector']
getgenv()['make_writeable'] = backup_env['make_writeable']
getgenv()['rconsoleinput'] = newcclosure(function() end)
getgenv()['getmenv'] = backup_env['getmenv']
getgenv()['getreg'] = backup_env['getreg']
getgenv()['syn_io_write'] = newcclosure(function() end)
getgenv()['messageboxasync'] = backup_env['messagebox']
getgenv()['getupvalues'] = backup_env['getupvalues']
getgenv()['setstack'] = backup_env['setstack']
getgenv()['syn_getinstances'] = newcclosure(function() end)
getgenv()['syn_context_get'] = backup_env['getthreadidentity']
getgenv()['syn_isactive'] = backup_env['isrbxactive']
syn["sirhurt_syn"] = nil

getgenv().identifyexecutor = newcclosure(function()
    return "Synapse X", "v2.3.4b";
end)
end)

local reverseKeyCode = {}
for _, item in pairs(Enum.KeyCode:GetEnumItems()) do
    reverseKeyCode[item.Value] = item
end

local map = {
    [0x20] = Enum.KeyCode.Space,
    [0xA0] = Enum.KeyCode.LeftShift,
    [0xA1] = Enum.KeyCode.RightShift,
    [0xA2] = Enum.KeyCode.LeftControl,
    [0xA3] = Enum.KeyCode.RightControl,
    [0xA4] = Enum.KeyCode.LeftAlt,
    [0xA5] = Enum.KeyCode.RightAlt,
}
for i = 0, 9 do map[i + 0x30] = reverseKeyCode[i + 48] end -- 0-9
for i = 0, 25 do map[i + 0x41] = reverseKeyCode[i + 97] end -- A-Z
for i = 0, 9 do map[i + 0x60] = reverseKeyCode[i + 256] end -- Keypad 0-9

local function getKeyCode(keyCode)
    if typeof(keyCode) ~= "EnumItem" or keyCode.EnumType ~= Enum.KeyCode then
        keyCode = map[keyCode]
        if keyCode == nil then
            keyCode = reverseKeyCode[keyCode]
        end
        assert(keyCode ~= nil, "invalid key code")
    end

    return keyCode
end

getgenv().keypress = keypress or newcclosure(function(keyCode)
    keyCode = getKeyCode(keyCode)

    virtualInputManager:SendKeyEvent(true, keyCode, false, nil)
end)

getgenv().keyrelease = keyrelease or newcclosure(function(keyCode)
    keyCode = getKeyCode(keyCode)

    virtualInputManager:SendKeyEvent(false, keyCode, false, nil)
end)

getgenv().movemouse = mousemove
--[[
getgenv().mousemoverel = newcclosure(function(x, y)
    assert(type(x) == "number", "x coordinate must be a number")
    assert(type(y) == "number", "y coordinate must be a number")

    local mouse = userInputService:GetMouseLocation()
    mousemove(mouse.X + x, mouse.Y + y)
end)]]

getgenv().movemouserel = getgenv().mousemoverel

local Input = {}
Input.LeftClick = function(action) if action == 'MOUSE_DOWN' then mouse1press() elseif action == 'MOUSE_UP' then mouse1release() end end
Input.MoveMouse = function(x,y) mousemoverel(x,y) end
Input.ScrollMouse = function(int) mousescroll(int) end
Input.KeyPress = function(key) keypress(key) wait() keyrelease(key) end
Input.KeyDown = function(key) keypress(key) end
Input.KeyUp = function(key) keyrelease(key) end
setreadonly(Input, true)
getgenv().Input = Input

getgenv().getcallingscript = getcallingscript or newcclosure(function()
    local depth = 2
    local env

    pcall(function()
        while true do
            nenv = getfenv(depth)
            if nenv == nil then return end
            env = nenv
            depth = depth + 1
        end
    end)

    return env and env.script or nil
end)

local oGetAsync = game.HttpGetAsync
if getnetworked then
getgenv().htgetf = function(url)
    local networked = getnetworked()
    setnetworked(3) -- roblox is gay
    local success, ret = pcall(oGetAsync, game, url)
    setnetworked(networked)

    if not success then error(ret) end

    return ret
end
end

local oPostAsync = game.HttpPostAsync
getgenv().htpostf = function(...)
    local networked = getnetworked()
    setnetworked(3) -- roblox is gay
    local success, ret = pcall(oPostAsync, game, ...)
    setnetworked(networked)

    if not success then error(ret) end

    return ret
end

local loadstring = loadstring
local loadfile = loadfile
local islclosure = islclosure
local checkcaller = checkcaller
local newcclosure = newcclosure

getgenv().checkcaller = newcclosure(function() return checkcaller() end)
getgenv().is_protosmasher_caller = newcclosure(function() return checkcaller() end)

local getService = game.GetService
local services = debug.setmetatable(newproxy(true), {
    __index = function(t, k)
        local s, v = pcall(getService, game, k)
        if s then return v else return nil end
    end
})

getgenv().iscclosure = newcclosure(function(...)
    return not islclosure(...)
end)

getgenv().dofile = newcclosure(function(...)
    return loadfile(...)()
end)

getgenv().isluau = newcclosure(function()
    return true
end)

if getgenv().decompile == nil then
    getgenv().decompile = newcclosure(function()
        return "-- sirhurt does not currently support decompile"
    end)
end

getgenv().getsenv = getsenv or newcclosure(function(script)
    for i,v in pairs(getgc()) do
        if type(v) == "function" and islclosure(v) then
            local env = getfenv(v)
            if env.script == script then
                return env
            end
        end
    end

    error("could not obtain script environment.")
end)

getgenv().getmenv = getmenv or getgenv().getsenv

getnilinstances = newcclosure(function()
	local instances = {}
	for i, v in next, getreg() do
		if type(v) == "table" then
			for memes, mylife in next, v do
				if typeof(mylife) == "Instance" and mylife.Parent == nil then
					table.insert(instances, mylife)
				end
			end
		end
	end
	return instances
end)

getgenv().getscripts = getscripts or function()
    local scripts = {}

    for i,v in next, getgc() do
        if type(v) == "userdata" and typeof(v) == "Instance" and v.ClassName and v.ClassName == "LocalScript" and not v.RobloxLocked then
            scripts[i] = v
        end
        if type(v) == "userdata" and typeof(v) == "Instance" and v.ClassName and v.ClassName == "ModuleScript" and not v.RobloxLocked then
            scripts[i] = v
        end
    end
    return scripts
end


--[[getgenv().decompile = newcclosure(function(...)
    return "--This function has been disabled by the Development team. We will be working on rewriting this function to be improved and more efficent. Stay tooned!";
end)]]


--quick writefile patch
local old_write = writefile;
local old_read = readfile;
local blacklisted_extensions = {".php", ".doc", ".jar",  ".zip", ".rar", ".iso", ".pdf", ".cpl"}

getgenv().writefile = newcclosure(function(path, contents)
    for i = 1, #blacklisted_extensions do
        if string.find(path, blacklisted_extensions[i])  then
            return error("Attempt to write illegal extension " .. blacklisted_extensions[i])
        end
    end

    return old_write(path, contents)
end)

getgenv().readfile = newcclosure(function(path)
    for i = 1, #blacklisted_extensions do
        if string.find(path, blacklisted_extensions[i])  then
            return error("Attempt to read illegal extension " .. blacklisted_extensions[i])
        end
    end

    return old_read(path)
end)

getgenv().unlockmodulescript = newcclosure(function() end)

getgenv().getnilinstances = getnilinstances
getgenv().get_nil_instances = getnilinstances

--SirHurt Custom Notifications
local SirhurtNotificationAdded = false;
local SirHurtNotification
local Notifications
local ActiveNotifications = 0

local DefaultStarting = 0.839
local Difference = 0.185

function CreateNotification(tab)
if (type(tab) ~= "table") then return warn("expected table, got " .. type(tab)) end    
if (tab.Title == nil) then tab.Title = "NOTIFICATION" end

if not SirhurtNotificationAdded then
    SirhurtNotificationAdded = true
    SirHurtNotification = Instance.new("ScreenGui", get_hidden_gui())
    Notifications = Instance.new("Frame", SirHurtNotification)

    SirHurtNotification.Name = "SirHurtNotification"
    SirHurtNotification.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    Notifications.Name = "Notifications"
    Notifications.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Notifications.BackgroundTransparency = 1.000
    Notifications.Position = UDim2.new(0.899030745, 0, 0.45, 0)
    Notifications.Size = UDim2.new(0.100969307, 0, 0.438253015, 0)
end

ActiveNotifications = ActiveNotifications + 1

local Frame = Instance.new("Frame", Notifications)
ImageLabel = Instance.new("ImageLabel", Frame)
TextLabel = Instance.new("TextLabel", Frame)

Frame.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
Frame.BackgroundTransparency = 0.700
Frame.BorderColor3 = Color3.fromRGB(162, 162, 162)
Frame.BorderSizePixel = 2
Frame.Position = UDim2.new(1, 0, DefaultStarting - (Difference * ActiveNotifications), 0)
Frame.Size = UDim2.new(0.999999881, 0, 0.160694048, 0)
Frame.ZIndex = 12

ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.BackgroundTransparency = 1.000
ImageLabel.Position = UDim2.new(0.131999999, 0, 0.0879999995, 0)
ImageLabel.Size = UDim2.new(0.145759374, 0, 0.389820725, 0)
ImageLabel.Image = "http://www.roblox.com/asset/?id=4576161499"

TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(0.0463917553, 0, 0.478056669, 0)
TextLabel.Size = UDim2.new(0.932989836, 0, 0.521944106, 0)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = tab.Body
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextStrokeTransparency = 0.800
TextLabel.TextWrapped = true

Title = Instance.new("TextLabel", Frame)
Title.Name = "Title"
Title.Parent = Frame
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.Position = UDim2.new(0.326000005, 0, 0.129999995, 0)
Title.Size = UDim2.new(0.57322979, 0, 0.287113816, 0)
Title.Font = Enum.Font.SourceSans
Title.Text = tab.Title
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14.000
Title.TextStrokeTransparency = 0.800
Title.TextWrapped = true
Title.TextScaled = true

Frame:TweenPosition(UDim2.new(0, 0, Frame.Position.Y.Scale, 0), "In", "Quad", 0.2)
wait(6)
Frame:TweenPosition(UDim2.new(1, 0, Frame.Position.Y.Scale, 0), "Out", "Quad", 0.2)

ActiveNotifications = ActiveNotifications - 1
end

getgenv().SIRHURT_NOTIFICATION = CreateNotification

if not is_sirhurt_closure(require) then
    oRequire = require;
    getgenv().require = function(ms)
        local old = getthreadidentity()
        setthreadidentity(2)
        local success, ret = pcall(oRequire, ms)
        setthreadidentity(old)
    
        if not success then error(ret) end
    
        return ret
    end
end


--[[local backup
backup = hookfunction(coroutine.wrap, function(...)
    return newcclosure(backup(...))
end)]]

--whatever you do, don't uncomment this or your a homo
--[[local oRequire
oRequire = hookfunction(getrenv().require, newcclosure(function(ms)
    local old = getthreadidentity()
    setthreadidentity(2)
    local success, ret = pcall(oRequire, ms)
    setthreadidentity(old)

    if not success then error(ret) end

    return ret
end))]]

if not Drawing then
    getgenv().Drawing = {}
    getgenv().Drawing.new = new_drawing
    getgenv().Drawing.clear = clear_drawings
end

-- prevent stack overflow
local isA = game.IsA
local insertService = services.InsertService
local loadLocalAsset = insertService.LoadLocalAsset
local find_str = string.find

local function starts_with(str, start)
    return str:sub(1, #start) == start
 end
 
local HttpGet_Save = newcclosure(function(self, path, sync)
return httpgetinternal(path, false)
end)

local GetObjects_Save = newcclosure(function(self, contentPath)
return { loadLocalAsset(insertService, contentPath) } -- TODO: real GetObjects
end)

local HttpPost_Save = newcclosure(function(self, path, b, c, d)
    
if (string.find(path, "trades.roblox.com")) then
    warn("BLACKLISTED_URL");
    return "NO LOL";
end

return httppostinternal(path, b, c, d)
end)

local browserService = services.BrowserService
local oOpenBrowserWindow = browserService.OpenBrowserWindow
local httpService = services.HttpService
local urlEncode = httpService.UrlEncode
local openbrowserwindow = newcclosure(function(self, url)
    
    return newcclosure(function() error("Attempt to call illegal function.") while true do end end)
        
    --return oOpenBrowserWindow(browserService, "https://sirhurt.net\\asshurt\\redirect.php?url=" .. urlEncode(httpService, tostring(url)) .. "?www.roblox.com")
end)

local function reverse_string(s)
  local r = ""
  for i = 1,#s,1 do
    r = s:sub(i,i) .. r
  end
  return r
end

local MarketIB =
{
    ["Perform"] = true,
    ["Prompt"] = true
}

local MarketBlacklistedGlobals = {}

for I, _ in pairs(MarketIB) do
	MarketBlacklistedGlobals[reverse_string(I)] = true
end

MarketIB = {}

setreadonly(MarketBlacklistedGlobals, true)

local function handleIndex(t, k, isNamecall)
    if isA(t, reverse_string("ledoMataD")) then
        k = k:gsub('(.-)\0','%1')
        if starts_with(k, reverse_string("redloFstohsneercSnepO")) or starts_with(k, reverse_string("redloFsoediVnepO")) then
            return newcclosure(function()
                error("attempt to call illegal function '" .. k .. "'")
                while true do end
            end)
        elseif k == reverse_string("stcejbOteG") then
            if not isNamecall then 
                return GetObjects_Save
            else
                return newcclosure(function(self, contentPath)
                    return { loadLocalAsset(insertService, contentPath) } -- TODO: real GetObjects
                end)
            end
        elseif k == reverse_string("teGpttH") or k == reverse_string("cnysAteGpttH") then
            if not isNamecall then 
                return HttpGet_Save 
            else 
                return newcclosure(function(self, path, sync)
                    return httpgetinternal(path, false)
                end) 
            end
        elseif k == reverse_string("tsoPpttH") or k == reverse_string("cnysAtsoPpttH") then
            if not isNamecall then 
            return HttpPost_Save
            else
                return newcclosure(function(self, path, b, c, d)
                    if (string.find(path, "trades.roblox.com")) then
                        warn("BLACKLISTED_URL");
                        return "NO LOL";
                    end

                    return httppostinternal(path, b, c, d)
                end)
            end
        end

        return not isNamecall and services[k] or nil
    elseif isA(t, reverse_string("ecivreStresnI")) then
        if k == reverse_string("tessAdaoL") then
            --warn("LoadAsset is deprecated, please use LoadLocalAsset in its place.")
            return loadLocalAsset
        end
    elseif isA(t, reverse_string("ecivreSegarotSmeM")) then
        if starts_with(k, reverse_string("elbaTteG")) then
            return newcclosure(function()
                error("attempt to call illegal function '" .. k .. "'")
                while true do end
            end)
        end   
    elseif isA(t, reverse_string("ecivreSiuG")) then
        if starts_with(k, reverse_string("wodniWresworBnepO")) then
            return newcclosure(function() error("Attempt to call illegal function.") while true do end end)
        end   
    elseif isA(t, reverse_string("ecivreSresworB")) then
        if starts_with(k, reverse_string("wodniWresworBnepO")) then
            return newcclosure(function() error("Attempt to call illegal function.") while true do end end)
        end      
    elseif isA(t, reverse_string("ecivreSecalptekraM")) then
        for I, _ in pairs(MarketBlacklistedGlobals) do
        --function dummy() end
        if find_str(k, reverse_string(I)) or find_str(k, reverse_string(I)) then
            return newcclosure(function()
                error("attempt to call illegal function '" .. k .. "'")
                while true do end
            end)
        end
        end
    end

    return nil
end

--[[
local instanceMt = getrawmetatable(game)

setreadonly(instanceMt, false)
local oInstanceIndex = instanceMt.__index
instanceMt.__index = newcclosure(function(t, k)
    if checkcaller() then
        local res = handleIndex(t, k)
        if res ~= nil then
            return res
        end
    end
    
    return oInstanceIndex(t, k)
end)

local oInstanceNamecall = instanceMt.__namecall
instanceMt.__namecall = newcclosure(function(t, ...)
    if checkcaller() then
        local res = handleIndex(t, getnamecallmethod(), true)
        if res ~= nil then
            return res(t, ...)
        end
    end
    
    return oInstanceNamecall(t, ...)
end)
setreadonly(instanceMt, true)
]]

local instanceMt = getrawmetatable(game)
setreadonly(instanceMt, false)

upvalueid(instanceMt);

setreadonly(instanceMt, true)
--getgenv().upvalueid = nil


-------------------
--! Shared/_G Override !--
-------------------

local shared_org = getrenv().shared
local _G_org = getrenv()._G

getgenv()._G = {};
getrenv()._G = _G_org;

getgenv().shared = {};
getrenv().shared = shared_org;

Copy_G = newcclosure(function(a, b) _G[a] = b; end)
Copy_shared = newcclosure(function(a, b) shared[a] = b; end)
table.foreach(shared_org, Copy_shared)
table.foreach(_G_org, Copy_G)

-- save metatables
--[[
local revent_save = Instance.new("RemoteEvent")
local rfunction_save = Instance.new("RemoteFunction")

shared['event'] = revent_save;
shared['function'] = rfunction_save;

sirhurt_DSJKDSJDHJS = sirhurt_DSJKDSJDHJS or function(...) end
sirhurt_DSJKDSJDHJS(revent_save.FireServer, rfunction_save.InvokeServer)
]]
getgenv().sirhurt_DSJKDSJDHJS = nil

-- teleport handler
spawn(function()
    local localPlayer = nil
    repeat
        localPlayer = services.Players.LocalPlayer
    until localPlayer ~= nil

    localPlayer.OnTeleport:Connect(function(state)
        if state == Enum.TeleportState.InProgress then
            teleportcbinternal()
        end
    end)
    
    game:GetService("GuiService").ErrorMessageChanged:connect(function(msg)
        if string.find(msg, "You were kicked from this game") then
	    reportkick(game.PlaceId, string.gsub(msg, "You were kicked from this game: ", ""))
	    end
    end)
end)

-- declare autorun / queued scripts as ready to load
if (sirhurt_run_queued_scripts) then
local sirhurt_run_queued_scripts = sirhurt_run_queued_scripts;
getgenv().sirhurt_run_queued_scripts = nil

sirhurt_run_queued_scripts();
end

--i could take a shit and that shit would write a better method -icepools
if (save_roblox_headers) then
local save_roblox_headers = save_roblox_headers;
getgenv().save_roblox_headers = nil

--TODO: Strucid Detection of 'htgetf'
--save_roblox_headers(htgetf("https://www.sirhurt.net/asshurt/testt.php"))
end
