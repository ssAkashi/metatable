---@class entity
entity = {}

---@class Peds
Peds = setmetatable({}, Peds)
Peds.__index = Peds
Peds.__call = function()
    return true
end

---createPed
---@param Hash string
---@param Pos number
---@return Peds
---@public
function entity:createPed(Hash, Pos)
    local self = {}
    RequestModel(Hash)
    while not HasModelLoaded(Hash) do Wait(10) end
    self.id = CreatePed(1, GetHashKey(Hash), Pos.x, Pos.y, Pos.z, 90.0, true, true)
    self.pos = Pos

    return setmetatable(self, Peds)
end

---setCoords
---@param coord number
---@return void
---@public
function Peds:setCoords(coord)
    if DoesEntityExist(self.id) then
        SetEntityCoords(self.id, coord)
    end
end

---getCoords
---@return Peds
---@public
function Peds:getCoords()
    return self.pos
end

---freeze
---@return void
---@public
function Peds:freeze(bool)
    if DoesEntityExist(self.id) then
        if bool then
            FreezeEntityPosition(self.id, true)
        else
            FreezeEntityPosition(self.id, false)
        end
    end
end

---kill
---@return void
---@public
function Peds:kill()
    if DoesEntityExist(self.id) then
        SetEntityHealth(self.id, 0)
    end
end

---delete
---@return void
---@public
function Peds:delete()
    if DoesEntityExist(self.id) then
        DeleteEntity(self.id)
    end
end

RegisterCommand("Createped", function()
    ped1 = entity:createPed('ig_barry', GetEntityCoords(PlayerPedId()))
    ped2 = entity:createPed('cs_casey', GetEntityCoords(PlayerPedId()))
end)

RegisterCommand("actionped1", function(source,args)
    if ped1 and ped2 ~= nil then
        if args[1] == "kill" then
            ped1:kill()
        elseif args[1] == "freeze" then
            ped1:freeze(true)
        elseif args[1] == "unfreeze" then
            ped1:freeze(false)
        elseif args[1] == "coords" then
            ped1:setCoords(ped2:getCoords())
        end
    end
end)

RegisterCommand("actionped2", function(source,args)
    if ped1 and ped2 ~= nil then
        if args[1] == "kill" then
            ped2:kill()
        elseif args[1] == "freeze" then
            ped2:freeze(true)
        elseif args[1] == "unfreeze" then
            ped2:freeze(false)
        elseif args[1] == "coords" then
            ped2:setCoords(ped1:getCoords())
        end
    end
end)

RegisterCommand("destroyped", function(source,args)
    if ped1 and ped2 ~= nil then
        ped1:delete()
        ped2:delete()
        ped1 = nil
        ped2 = nil
    end
end)