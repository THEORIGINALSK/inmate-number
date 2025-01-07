-- Generate Random Inmate Number
local function generateRandomNumber()
    return math.random(10000, 99999) -- 5-digit random number
end

-- Register Server Event
RegisterNetEvent('inmate:register')
AddEventHandler('inmate:register', function()
    local source = source
    local identifier = GetPlayerIdentifiers(source)[1]

    print("Registering inmate for identifier:", identifier)

    exports.oxmysql:fetch("SELECT * FROM inmates WHERE identifier = ?", {identifier}, function(result)
        if result then
            print("Query result:", json.encode(result))
            if #result == 0 then
                local inmateNumber = generateRandomNumber()
                exports.oxmysql:insert("INSERT INTO inmates (identifier, inmatenumber) VALUES (?, ?)", {
                    identifier,
                    inmateNumber
                }, function(insertedId)
                    print("Inserted new inmate with number:", inmateNumber, "for identifier:", identifier)
                    TriggerClientEvent('ox_lib:notify', source, {
                        title = 'Inmate Registered',
                        description = 'Your new inmate number is: ' .. inmateNumber,
                        type = 'success'
                    })
                end)
            else
                print("Identifier already exists with inmate number:", result[1].inmatenumber)
                TriggerClientEvent('ox_lib:notify', source, {
                    title = 'Already Registered',
                    description = 'You already have an inmate number: ' .. result[1].inmatenumber,
                    type = 'inform'
                })
            end
        else
            print("Error fetching data for identifier:", identifier)
        end
    end)
end)
