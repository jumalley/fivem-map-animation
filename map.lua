local inMenuMode = false
local animationPlaying = false
local playerProps = {}

local animDict = "amb@world_human_tourist_map@male@idle_b"
local animName = "idle_d"
local propModel = "p_tourist_map_01_s"
local propBone = 28422

CreateThread(function()
    while true do
        Wait(500)

        local player = PlayerPedId()

        if IsPauseMenuActive() and not inMenuMode and not IsPedInAnyVehicle(player) then
            playMapAnimation(player)
        elseif not IsPauseMenuActive() then
            if animationPlaying then
                ClearPedTasks(player)
                animationPlaying = false
            end
            inMenuMode = false
            destroyAllProps()
        end
    end
end)

function playMapAnimation(player)
    animationPlaying = true
    inMenuMode = true

    loadAnim(animDict)
    addPropToPlayer(propModel, propBone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)

    TaskPlayAnim(player, animDict, animName, 2.0, 8.0, -1, 53, 0, false, false, false)
end

function loadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

function loadModel(model)
    local modelHash = GetHashKey(model)
    while not HasModelLoaded(modelHash) do
        RequestModel(modelHash)
        Wait(10)
    end
end

function addPropToPlayer(model, bone, offX, offY, offZ, rotX, rotY, rotZ)
    local player = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(player))

    loadModel(model)

    local prop = CreateObject(GetHashKey(model), x, y, z + 0.2, true, true, true)
    AttachEntityToEntity(prop, player, GetPedBoneIndex(player, bone), offX, offY, offZ, rotX, rotY, rotZ, true, true, false, true, 1, true)
    table.insert(playerProps, prop)

    SetModelAsNoLongerNeeded(model)
end

function destroyAllProps()
    for _, prop in pairs(playerProps) do
        DeleteEntity(prop)
    end
    playerProps = {}
end
