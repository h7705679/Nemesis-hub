local a=game:GetService"Players"
local b=game:GetService"RunService"
local c=game:GetService"Workspace"

local d=a.LocalPlayer
local e=d.Character or d.CharacterAdded:Wait()
local f=e:WaitForChild"HumanoidRootPart"
local g=c.CurrentCamera

d.CharacterAdded:Connect(function(h)
e=h
f=e:WaitForChild"HumanoidRootPart"
end)

b.Stepped:Connect(function()
if e then
for h,i in ipairs(e:GetDescendants())do
if i:IsA"BasePart"then
i.CanCollide=false
end
end
end
end)

b.RenderStepped:Connect(function()
if f and f.Parent then
f.AssemblyLinearVelocity=Vector3.new(0,0,0)
f.AssemblyAngularVelocity=Vector3.new(0,0,0)
end
end)

local function getRoot(h)
if not h then return nil end
if h:IsA"BasePart"then return h end
if h:IsA"Model"then return h.PrimaryPart or h:FindFirstChildWhichIsA"BasePart"end
return h:FindFirstChildWhichIsA("BasePart",true)
end

local function aimAt(h)
if not g then return end local i=
g.CameraType
g.CameraType=Enum.CameraType.Scriptable

g.CFrame=CFrame.new(g.CFrame.Position,h)
task.wait(0.05)

g.CameraType=Enum.CameraType.Custom
end

local function isPositionSafe(h,i)
i=i or 15
local j=c:FindFirstChild"Mobs"

if not j then
return true
end

for k,l in ipairs(j:GetChildren())do
local m=getRoot(l)
if m then
local n=(m.Position-h).Magnitude
if n<=i then
return false
end
end
end

return true
end

task.spawn(function()
while task.wait(0.5)do
local h=c:FindFirstChild"Storages"
if h then
for i,j in ipairs(h:GetChildren())do
local k=j:FindFirstChild"Contents"
local l=k and k:FindFirstChild"Objects"

if not l or#l:GetChildren()==0 then
local m=j:FindFirstChild"Room"or(j.Name=="Room"and j)
if m then
local n=m:FindFirstChild"Door"
local o=getRoot(n)

if o then
local p=o.Position

if isPositionSafe(p,15)then
f.CFrame=o.CFrame+(o.CFrame.LookVector*0.5)+Vector3.new(0,3,0)
f.AssemblyLinearVelocity=Vector3.new(0,0,0)

task.wait(0.2)
aimAt(p)

local q=n:FindFirstChildWhichIsA("ProximityPrompt",true)
if q then
q.MaxActivationDistance=9e9
fireproximityprompt(q)
end

task.wait(1.5)
end
end
end
end

pcall(function()
local m=j:FindFirstChild"Contents"
local n=m and m:FindFirstChild"Loot"

if n then
for o,p in ipairs(n:GetChildren())do
local q=getRoot(p)
if q then
local r=q.Position

if isPositionSafe(r,15)then
f.CFrame=q.CFrame+Vector3.new(0,3,0)
f.AssemblyLinearVelocity=Vector3.new(0,0,0)

task.wait(0.05)
aimAt(r)

local s=p:FindFirstChildWhichIsA("ProximityPrompt",true)
if s then
s.MaxActivationDistance=9e9
fireproximityprompt(s)
end

local t=tick()
while p.Parent and q.Parent and(tick()-t<3)do
task.wait(0.05)
end
end
end
end
end
end)
end
end
end
end)
