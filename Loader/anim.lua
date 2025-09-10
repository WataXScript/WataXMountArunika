local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local function setup(char)
    local humanoid = char:WaitForChild("Humanoid")
    local hrp = char:WaitForChild("HumanoidRootPart")
    local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)

    local walkAnim = Instance.new("Animation")
    if humanoid.RigType == Enum.HumanoidRigType.R6 then
        walkAnim.AnimationId = "rbxassetid://180426354" 
    else
        walkAnim.AnimationId = "rbxassetid://507777826" 
    end

    local walkTrack = animator:LoadAnimation(walkAnim)
    walkTrack.Looped = true

    local lastPos = hrp.Position
    local isWalking = false
    local stopTimer = 0

    RunService.RenderStepped:Connect(function(dt)
        if not hrp or not hrp.Parent then return end
        local dist = (hrp.Position - lastPos).Magnitude

        if dist > 0.05 then
            stopTimer = 0
            if not isWalking then
                walkTrack:Play(0.2) 
                isWalking = true
            end
        else
            if isWalking then
                stopTimer = stopTimer + dt
                if stopTimer > 0.3 then 
                    walkTrack:Stop(0.2) 
                    isWalking = false
                end
            end
        end

        lastPos = hrp.Position
    end)
end

player.CharacterAdded:Connect(setup)
if player.Character then setup(player.Character) end
