CAdvertsTimers = CAdvertsTimers or {}

function Load() 
    include("cadverts_config.lua")
    for i,v in pairs(CAdvertsTimers) do
        timer.Remove(i)
        CAdvertsTimers[i] = nil
    end

    if #CAdverts.Repeating > 0 then
        for i,v in pairs(CAdverts.Repeating) do
            timer.Create(v.name, v.every, 0, function()
                CLib.Chat.ServerMessage(v.content, { formatColor = true })
            end)

            CAdvertsTimers[v.name] = true

            print("[CAdverts] Loaded repeating advert: " .. v.name)
        end
    end

    local curAdvert = 1
    if #CAdverts.Rotation.adverts > 0 then
        timer.Create("rotation", CAdverts.Rotation.every, 0, function()
            if curAdvert > #CAdverts.Rotation.adverts then curAdvert = 1 end
            CLib.Chat.ServerMessage(CAdverts.Rotation.adverts[curAdvert], { formatColor = true })
            curAdvert = curAdvert + 1
        end)

        CAdvertsTimers.rotation = true

        print("[CAdverts] Loaded rotating advert")
    end
end

concommand.Add("cadverts_reload", Load)
Load()