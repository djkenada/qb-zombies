local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

	--[[ Config Zombie Models ]]--
	local Models = {
		"u_f_m_corpse_01",
		"u_f_y_corpse_01",
		"u_m_y_corpse_01",
		"u_m_y_zombie_01",
		"mp_f_cocaine_01",
		"mp_m_cocaine_01",
		"mp_f_meth_01",
		"mp_m_meth_01",
		"s_m_y_factory_01",
		"u_m_o_filmnoir",
	}
  
	--[[ Config Zombie Walk Styles  ]]--		  
	local walks = {
		"move_m@drunk@verydrunk",
		"move_m@drunk@moderatedrunk",
		"move_m@drunk@a",
		"anim_group_move_ballistic",
		"move_lester_CaneUp",
	}

	--[[ Load Players  ]]--
	players = {}

		RegisterNetEvent("qb-zombies:playerupdate")
		AddEventHandler("qb-zombies:playerupdate", function(mPlayers)
			players = mPlayers
		end)

	--[[ Load Zombies  ]]--
	entitys = {}
		
		TriggerServerEvent("RegisterNewZombie")
		TriggerServerEvent("qb-zombies:newplayer", PlayerId())
	
		RegisterNetEvent("ZombieSync")
		AddEventHandler("ZombieSync", function()
			AddRelationshipGroup("zombie")
			SetRelationshipBetweenGroups(0, GetHashKey("zombie"), GetHashKey("PLAYER"))
			SetRelationshipBetweenGroups(2, GetHashKey("PLAYER"), GetHashKey("zombie"))
				while true do
					Citizen.Wait(1)
					if #entitys < Config.SpawnZombie then
						x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))				
						EntityModel = Models[math.random(1, #Models)]
						EntityModel = string.upper(EntityModel)
						RequestModel(GetHashKey(EntityModel))
						while not HasModelLoaded(GetHashKey(EntityModel)) or not HasCollisionForModelLoaded(GetHashKey(EntityModel)) do
							Wait(1)
						end
						
						local posX = x
						local posY = y
						local posZ = z + 999.0

						repeat
							Wait(1)

							posX = x + math.random(-Config.MaxSpawnDistance, Config.MaxSpawnDistance)
							posY = y + math.random(-Config.MaxSpawnDistance, Config.MaxSpawnDistance)

							_,posZ = GetGroundZFor_3dCoord(posX+.0,posY+.0,z,1)

							for _, player in pairs(players) do
								Wait(1)
								playerX, playerY = table.unpack(GetEntityCoords(GetPlayerPed(player), true))
								if posX > playerX - Config.MinSpawnDistance and posX < playerX + Config.MinSpawnDistance or posY > playerY - Config.MinSpawnDistance and posY < playerY + Config.MinSpawnDistance then
									canSpawn = false
									break
								else
									canSpawn = true
								end
							end
						until canSpawn
						--[[ Spawns Zombie ]]--
						entity = CreatePed(4, GetHashKey(EntityModel), posX, posY, posZ, 0.0, true, false)
						
						--[[ Sets Zombie Walk Style--]]
						walk = walks[math.random(1, #walks)]			
						RequestAnimSet(walk)
						while not HasAnimSetLoaded(walk) do
							Citizen.Wait(1)
						end
						
						--[[ Sets Zombie Actions ]]--
						SetPedMaxHealth(entity, 140)
						SetEntityHealth(entity, 140)
						SetEntityMaxSpeed(entity, 75.0)
						SetPedPathCanUseClimbovers(entity, true)
						SetPedPathCanUseLadders(entity, false)
						SetPedHearingRange(entity, 200)
						SetPedMovementClipset(entity, walk, 1.4)
						TaskWanderStandard(entity, 1.0, 10)
						SetCanAttackFriendly(entity, false, false)
						SetPedCanEvasiveDive(entity, false)
						SetPedCombatAbility(entity, 100)
						SetPedAsEnemy(entity,false)
						SetPedAlertness(entity,3)
						SetPedIsDrunk(entity, true)
						SetPedConfigFlag(entity,100,1)
						ApplyPedDamagePack(entity,"BigHitByVehicle", 0.0, 9.0)
						ApplyPedDamagePack(entity,"SCR_Dumpster", 0.0, 9.0)
						ApplyPedDamagePack(entity,"SCR_Torture", 0.0, 9.0)
						DisablePedPainAudio(entity, true)
						SetPedRandomProps(entity)
						StopPedSpeaking(entity, true)
						SetEntityAsMissionEntity(entity, true, true)
						SetAiMeleeWeaponDamageModifier(0.01)
						SetPedShootRate(entity,  750)
						SetPedCombatAttributes(entity, 46, true)
						SetPedFleeAttributes(entity, 0, 0)
						SetPedCombatRange(entity, 2)
						SetPedCombatMovement(entity, 46)
						TaskCombatPed(entity, GetPlayerPed(-1), 0,16)
						TaskLeaveVehicle(entity, vehicle, 0)
						SetBlockingOfNonTemporaryEvents(entity, true) -- Stops them breaking anims and acting fruity when a gun is aimed at them

						if not NetworkGetEntityIsNetworked(entity) then
							NetworkRegisterEntityAsNetworked(entity)
						end

						table.insert(entitys, entity)
						
					end	

					for i, entity in pairs(entitys) do
						if not DoesEntityExist(entity) then
							SetEntityAsNoLongerNeeded(entity)
							table.remove(entitys, i)
						else
							local playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
							local pedX, pedY, pedZ = table.unpack(GetEntityCoords(entity, true))	
								
							if pedX < playerX - Config.DespawnDistance or pedX > playerX + Config.DespawnDistance or pedY < playerY - Config.DespawnDistance or pedY > playerY + Config.DespawnDistance then
								local model = GetEntityModel(entity)
								SetEntityAsNoLongerNeeded(entity)
								SetModelAsNoLongerNeeded(model)
								table.remove(entitys, i)

							end
						end
							
						if IsEntityInWater(entity) then
							local model = GetEntityModel(entity)
							SetEntityAsNoLongerNeeded(entity)
							SetModelAsNoLongerNeeded(model)
							DeleteEntity(entity)
							table.remove(entitys,i)
						end
					end
				end
			end)

			--[[ Zombie sounds ]]--
			Citizen.CreateThread(function()
				while true do
					Citizen.Wait(10000)
					for i, entity in pairs(entitys) do
						playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
						pedX, pedY, pedZ = table.unpack(GetEntityCoords(entity, true))
						if IsPedDeadOrDying(entity, 1) == 1 then
							--none :v
						else
							if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) <= 10.0 ) then

								TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, "Codzombie", 1.0)

							end
						end
					end
				end
			end)

			Citizen.CreateThread(function()
				while true do
					Citizen.Wait(1000)
					for i, entity in pairs(entitys) do
						for j, player in pairs(players) do
							local playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(player), true))
							local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(entity), true)
							
							if distance <= 5.0 then --------------------------------cange distance
								TaskGoToEntity(entity, GetPlayerPed(player), -1, 0.0, 1.0, 1073741824, 0)
							end
						end
					end
				end
			end)

			Citizen.CreateThread(function()
				while true do
					Citizen.Wait(1)
					for i, entity in pairs(entitys) do
						playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
						pedX, pedY, pedZ = table.unpack(GetEntityCoords(entity, true))
						if IsPedDeadOrDying(entity, 1) == 1 then
							--none :v
						else
							if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) < 0.6)then
								if IsPedRagdoll(entity, 1) ~= 1 then
									if not IsPedGettingUp(entity) then
										RequestAnimDict("misscarsteal4@actor")
										TaskPlayAnim(entity,"misscarsteal4@actor","stumble",1.0, 1.0, 500, 9, 1.0, 0, 0, 0)
										local playerPed = (GetPlayerPed(-1))
										local maxHealth = GetEntityMaxHealth(playerPed)
										local health = GetEntityHealth(playerPed)
										local newHealth = health - 2 
										SetEntityHealth(playerPed, newHealth)
										Wait(2000)	
										TaskGoToEntity(entity, GetPlayerPed(-1), -1, 0.0, 1.0, 1073741824, 0)
										--TaskGoStraightToCoord(entity, playerX, playerY, playerZ, 1.0, 0, 0,0)
									end
								end
							end
						end
					end
				end
			end)

			--[[ No Health Recharge Function ]]--
			if Config.NotHealthRecharge then
				SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
			end

			--[[ Mute Ambience Function ]]--
			if Config.MuteAmbience then
				StartAudioScene('CHARACTER_CHANGE_IN_SKY_SCENE')
			end

			--[[ Set Player Stats Function ]]--
			Citizen.CreateThread( function()
				while true do
					Citizen.Wait(0)
					RestorePlayerStamina(PlayerId(), 1.0)

					SetPlayerMeleeWeaponDamageModifier(PlayerId(), 0.1)
					SetPlayerMeleeWeaponDefenseModifier(PlayerId(), 0.0)
					SetPlayerWeaponDamageModifier(PlayerId(), 0.4)
					SetPlayerTargetingMode(2)

				end
			end)

			--[[ Zombie Loot Drop Function ]]--
			if Config.ZombieDropLoot then
				Citizen.CreateThread(function()
					while true do
						Citizen.Wait(1)
						for i, entity in pairs(entitys) do
							playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
							pedX, pedY, pedZ = table.unpack(GetEntityCoords(entity, true))
							if DoesEntityExist(entity) == false then
								table.remove(entitys, i)
							end
							if IsPedDeadOrDying(entity, 1) == 1 then
								if GetPedSourceOfDeath(entity) == PlayerPedId() then
									playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
									pedX, pedY, pedZ = table.unpack(GetEntityCoords(entity, true))	
									if not IsPedInAnyVehicle(PlayerPedId(), false) then
										if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) < 4.0) then
											QBCore.Functions.DrawText3D(pedX, pedY, pedZ + 0.2, 'Search Zombie - [~g~E~w~]')
											if IsControlJustReleased(1, 51) then
												if DoesEntityExist(GetPlayerPed(-1)) then
													RequestAnimDict("random@domestic")
													while not HasAnimDictLoaded("random@domestic") do
														Citizen.Wait(1)
													end
													TaskPlayAnim(PlayerPedId(), "random@domestic", "pickup_low", 8.0, -8, 2000, 2, 0, 0, 0, 0)
													Citizen.Wait(2000)
													randomChance = math.random(1, 100)
													TriggerServerEvent('qb-zombies:partloot')
													if randomChance < Config.ProbabilityMoneyLoot then
														TriggerServerEvent('qb-zombies:moneyloot')
													elseif randomChance >= Config.ProbabilityMoneyLoot and randomChance < Config.ProbabilityItemLoot then
														TriggerServerEvent('qb-zombies:itemloot')
													elseif randomChance >= Config.ProbabilityItemLoot and randomChance < 100 then
														QBCore.Functions.Notify('Zombie had nothing on them!','error')
													end
														
													ClearPedSecondaryTask(GetPlayerPed(-1))
													local model = GetEntityModel(entity)
													SetEntityAsNoLongerNeeded(entity)
													SetModelAsNoLongerNeeded(model)
													DeleteEntity(entity)
													table.remove(entitys, i)
												end
											end
										end
									end
								end
							end
						end
					end
				end)
			end

			--[[ Set Safe Zone Areas Function  ]]--
			if Config.SafeZone then
				Citizen.CreateThread(function()
					while true do
						Citizen.Wait(1)
						for k, v in pairs(Config.SafeZoneCoords) do
							for i, entity in pairs(entitys) do
								pedX, pedY, pedZ = table.unpack(GetEntityCoords(entity, true))
								if(Vdist(pedX, pedY, pedZ, v.x, v.y, v.z) < v.radio)then
									SetEntityHealth(entity, 0)
									SetEntityAsNoLongerNeeded(entity)
									DeleteEntity(entity)
									table.remove(entitys, i)
								end
							end
						end
					end
				end)

			end

			--[[ Safe Zone Blip Function ]]--
			if Config.SafeZoneRadioBlip then
				Citizen.CreateThread(function()
					for k,v in pairs(Config.SafeZoneCoords) do
						local blip = AddBlipForRadius(v.x, v.y, v.z , 40.0) -- you can use a higher number for a bigger zone

						SetBlipHighDetail(blip, true)
						SetBlipColour(blip, 2)
						SetBlipAlpha (blip, 128)

						local blip = AddBlipForCoord(v.x, v.y, v.z)

						SetBlipSprite (blip, v.sprite)
						SetBlipDisplay(blip, 4)
						SetBlipScale  (blip, 0.9)
						SetBlipColour (blip, v.color)
						SetBlipAsShortRange(blip, true)

						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(v.name)
						EndTextCommandSetBlipName(blip)
					end
				end)
			end


			--[[ Clear All Zombies Function ]]--
			RegisterNetEvent('qb-zombies:clear')
			AddEventHandler('qb-zombies:clear', function()
				for i, entity in pairs(entitys) do
					local model = GetEntityModel(entity)
					SetEntityAsNoLongerNeeded(entity)
					SetModelAsNoLongerNeeded(model)
					table.remove(entitys, i)
				end
			end)


			--[[ Debug Function  ]]--
			if Config.Debug then
				Citizen.CreateThread(function()
					while true do
						Citizen.Wait(1)
						for i, entity in pairs(entitys) do
							local playerX, playerY, playerZ = table.unpack(GetEntityCoords(PlayerPedId(), true))
							local pedX, pedY, pedZ = table.unpack(GetEntityCoords(entity, false))	
							DrawLine(playerX, playerY, playerZ, pedX, pedY, pedZ, 250,0,0,250)
						end
					end
				end)
			end

			--[[ No PEDs Function ]]--
			if Config.NoPeds then
				Citizen.CreateThread(function()
					while true do
						Citizen.Wait(1)
						SetVehicleDensityMultiplierThisFrame(0.0)
						SetPedDensityMultiplierThisFrame(0.0)
						SetRandomVehicleDensityMultiplierThisFrame(0.0)
						SetParkedVehicleDensityMultiplierThisFrame(0.0)
						SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
						local playerPed = GetPlayerPed(-1)
						local pos = GetEntityCoords(playerPed) 
						RemoveVehiclesFromGeneratorsInArea(pos['x'] - 500.0, pos['y'] - 500.0, pos['z'] - 500.0, pos['x'] + 500.0, pos['y'] + 500.0, pos['z'] + 500.0);
						SetGarbageTrucks(0)
						SetRandomBoats(0)
						CancelCurrentPoliceReport()
						
						for i=0,20 do
							EnableDispatchService(i, false)
						end
					end
				end)
			end
