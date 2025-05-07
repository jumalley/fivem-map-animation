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

        if IsPauseMenuActive() then
            handleMenuMode(player)
        else
            handleExitMenuMode(player)
        end
    end
end)

function handleMenuMode(player)
    if not inMenuMode and not IsPedInAnyVehicle(player) then
        playMapAnimation(player)
    end
end

function handleExitMenuMode(player)
    if animationPlaying then
        ClearPedTasks(player)
        animationPlaying = false
    end

    if inMenuMode then
        inMenuMode = false
        destroyAllProps()
    end
end

function playMapAnimation(player)
    animationPlaying = true
    inMenuMode = true

    loadAnim(animDict)
    addPropToPlayer(propModel, propBone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
    TaskPlayAnim(player, animDict, animName, 2.0, 8.0, -1, 53, 0, false, false, false)
end

function loadAnim(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(10)
        end
    end
end

function loadModel(model)
    local modelHash = GetHashKey(model)
    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Wait(10)
        end
    end
end

function addPropToPlayer(model, bone, offX, offY, offZ, rotX, rotY, rotZ)
    loadModel(model)

    local player = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(player))

    local prop = CreateObject(GetHashKey(model), x, y, z + 0.2, true, true, true)
    AttachEntityToEntity(prop, player, GetPedBoneIndex(player, bone), offX, offY, offZ, rotX, rotY, rotZ, true, true, false, true, 1, true)
    table.insert(playerProps, prop)

    SetModelAsNoLongerNeeded(model)
end

function destroyAllProps()
    if #playerProps > 0 then
        for _, prop in pairs(playerProps) do
            DeleteEntity(prop)
        end
        playerProps = {}
    end
end
