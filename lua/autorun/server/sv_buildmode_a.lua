hook.Add("PlayerInitialSpawn", "BuildMode_PlayerInitialSpawn", function(ply)
  ply.build = {}
  ply.build.active = false
  ply.build.spawning = false
  ply.build.nextChange = CurTime()
end)

hook.Add("PlayerNoClip", "BuildMode_NoClip", function(ply, state)
  if not state or ply.build.active then return true end
end)

hook.Add("PlayerSpawn", "BuildMode_Spawn", function(ply)
  if ply.build.active then ply:GodEnable() end --If it shits make it run multiple times over on a timer, make sure spawn protection doesn't run at all for build players
end)

local function resolveAttacker(input)
  if not IsValid(input) then return nil end

  if input:IsPlayer() then return input end
  if input:IsVehicle() then 
    local driver = input:GetDriver()
    if IsValid(driver) then return driver end
  end

  return input:GetOwner()
end

hook.Add("EntityTakeDamage", "BuildMode_EntityTakeDamage", function(target, dmg)
  if not (IsValid(target) and target:IsPlayer()) then return nil end
  local attacker = resolveAttacker(dmg:GetAttacker())

  if IsValid(attacker) and attacker:IsPlayer() and (attacker.build.active or attacker.build.spawning) then
    dmg:SetDamage(0)
    return true
  end
end)

hook.Add("PlayerDeath", "BuildMode_PlayerDeath", function(victim, inflictor, attacker)
  if attacker == victim then return end
  attacker = resolveAttacker(attacker)

  if IsValid(attacker) and attacker:IsPlayer() and (attacker.build.active or attacker.build.spawning) then attacker:Kill() end
end)
