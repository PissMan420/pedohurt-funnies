local storage = Instance.new("Folder", game)
storage.Name = "GAME_SCRIPTS_SIRHURT"

local nil_instances = Instance.new("Folder", storage)
nil_instances.Name = "PARENTED TO NIL"

local others_folder = Instance.new("Folder", storage)
others_folder.Name = "OTHER"

local globals = {
	"Workspace",
	"Players",
	"Lighting",
	"ReplicatedStorage",
	"ReplicatedFirst",
	"StarterGui",
	"StarterPack"
}

for i,v in pairs(globals) do
	b = Instance.new("Folder", storage)
	b.Name = v
end

for i,v in pairs(game:GetDescendants()) do
pcall(function()
if v:IsA("LocalScript") then
	
descendant = "OTHER"
for l,b in pairs(globals) do
	if v:IsDescendantOf(game:GetService(b)) then
		descendant = b
		break;
	end
end
	
parentfolder = storage[descendant]:FindFirstChild(v.Parent.Name)
if parentfolder == nil and descendant ~= v.Parent.Name then
	parentfolder = Instance.new("Folder", storage[descendant])
	parentfolder.Name = v.Parent.Name
end
if (descendant == v.Parent.Name) then
	parentfolder = storage[descendant]
end

c = v:Clone()
c.Disabled = true
c.Parent = parentfolder;
end
if v:IsA("ModuleScript") then
	
descendant = "OTHER"
for l,b in pairs(globals) do
	if v:IsDescendantOf(game:GetService(b)) then
		descendant = b
		break;
	end
end

parentfolder = storage[descendant]:FindFirstChild(v.Parent.Name)
if parentfolder == nil and descendant ~= v.Parent.Name then
	parentfolder = Instance.new("Folder", storage[descendant])
	parentfolder.Name = v.Parent.Name
end
if (descendant == v.Parent.Name) then
	parentfolder = storage[descendant]
end

v:Clone().Parent = parentfolder
end
end)
end

for i,v in pairs(getnilinstances()) do
pcall(function()
if v:IsA("LocalScript") then
c = v:Clone()
c.Disabled = true
c.Parent = nil_instances;
end
if v:IsA("ModuleScript") then
v:Clone().Parent = nil_instances
end
end)
end