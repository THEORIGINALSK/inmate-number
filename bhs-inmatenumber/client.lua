-- Create Blip
Citizen.CreateThread(function()
    for _, info in pairs(config.InmateNumberBlip) do
        local blip = AddBlipForCoord(info.coords) -- Fixed function name
        SetBlipSprite(blip, info.id)
        SetBlipDisplay(blip, info.display)
        SetBlipScale(blip, info.scale)
        SetBlipColour(blip, info.color) -- Fixed color key
        SetBlipShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING") -- Fixed function name
        AddTextComponentString(info.name)
        EndTextCommandSetBlipName(blip)
    end
end)

-- Keybind and Input Handling
lib.addKeybind({
    name = 'inmate_number_keybind',
    defaultKey = 'E',
    onPressed = function(self)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local isNear = #(playerCoords - config.InmateNumberLocation.coords) < 5.0

        if isNear then
            -- Trigger server to generate random number and register inmate
            TriggerServerEvent('inmate:register')
        end
    end
})

-- Show TextUI when near
local point = lib.points.new({
    coords = config.InmateNumberLocation.coords,
    distance = 2.0
})

function point:onEnter()
    lib.showTextUI('[E] - Register Inmate Number', {
        position = 'top-center',
        icon = 'id-card',
        style = {
            borderRadius = 0,
            backgroundColor = '#48BB78',
            color = 'white'
        }
    })
end

function point:onExit()
    lib.hideTextUI()
end
