local oldScript = script;
local sirhurtGUI = game:GetObjects("rbxassetid://4741602174")[1];
sirhurtGUI.Parent = get_hidden_gui and get_hidden_gui() or game:GetService("CoreGui");
local loadstring = loadstring;

for i, v in next, sirhurtGUI:GetDescendants() do
    if v:IsA("LocalScript") then
        script = v;
        loadstring(v.Source)();
    end;
end;

script = oldScript;