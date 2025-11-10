-- ЧАСТЬ 5/6: Функции движения и NoFall
local LastNoFallTime = 0
local NoFallCooldown = 0.1

local function CheckNoFall()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then return end
    
    local currentTime = tick()
    if currentTime - LastNoFallTime < NoFallCooldown then return end
    
    if rootPart.Velocity.Y < -10 then
        local rayOrigin = rootPart.Position
        local rayDirection = Vector3.new(0, -50, 0)
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        raycastParams.FilterDescendantsInstances = {character}
        
        local rayResult = Workspace:Raycast(rayOrigin, rayDirection, raycastParams)
        
        if rayResult then
            local distanceToGround = (rayOrigin - rayResult.Position).Magnitude
            
            if distanceToGround <= 1 then
                local originalVelocity = rootPart.Velocity
                rootPart.Velocity = Vector3.new(originalVelocity.X, 0, originalVelocity.Z)
                rootPart.Velocity = Vector3.new(originalVelocity.X, 5, originalVelocity.Z)
                LastNoFallTime = currentTime
            end
        end
    end
end

local function InfiniteJumpVelocity()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then return end
    
    local currentTime = tick()
    if currentTime - LastInfJumpTime >= InfJumpCooldown then
        rootPart.Velocity = Vector3.new(rootPart.Velocity.X, 50, rootPart.Velocity.Z)
        LastInfJumpTime = currentTime
    end
end

local function ApplySpeedVelocity()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then return end
    
    local moveDirection = humanoid.MoveDirection
    if moveDirection.Magnitude > 0 then
        local velocityMultiplier = SpeedValue * 2
        local newVelocity = moveDirection * velocityMultiplier
        rootPart.Velocity = Vector3.new(newVelocity.X, rootPart.Velocity.Y, newVelocity.Z)
    end
end
