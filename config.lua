--[[ Default Config Settings ]]--
Config = {}
Config.Debug 					= false						-- Set to true for debuging.
Config.NoPeds 					= true						-- Set to true for no peds.
Config.MuteAmbience 			= false						-- Set to true to mute ambience.
Config.NotHealthRecharge 		= true						-- Set true to not all health auto recharge.

--[[ Zombie Spawn Config Settings ]]--
Config.SpawnZombie 				= 60 						-- Number of zombies to spawn per player.
Config.MinSpawnDistance 		= 45 						-- Minimum distance zombies spawn from player.
Config.MaxSpawnDistance 		= 60 						-- Max distance zombies spawn from player.
Config.DespawnDistance 			= 90 						-- How far away the zombies spawn.

--[[ Zombie Loot Config Settings ]]--
Config.ZombieDropLoot 			= true  					-- For zombies to drop loot, set to true.
Config.RandomChance 			= math.random(1, 100)  		-- Random number for giveaway chance.
Config.ItemAmount 				= math.random(1,5) 			-- Random number for the ammout of item given.
Config.AddtionalItem 			= false 					-- Set to true to give extra item on loot.
Config.AddItem 					= 'metalscrap' 				-- Extra item to give player.
Config.AddItemAmount 			= math.random(1,3) 			-- Random number for the ammout of extra item given.
Config.ProbabilityMoneyLoot 	= 33 						-- 33 = 30%
Config.ProbabilityItemLoot 		= 53 						-- 53-33 = 20%

--[[ Zombie Loot Items Config Settings ]]--
Config.Items = {
	[1] = "pistol_ammo",
	[2] = "rifle_ammo",
	[3] = "smg_ammo",
	[4] = "shotgun_ammo",
	[5] = "tosti",
	[6] = "twerks_candy",
	[7] = "snikkel_candy",
	[8] = "sandwich",
	[9] = "water_bottle",
	[10] = "kurkakola",
	[11] = "joint",
	[12] = "cokebaggy",
	[13] = "crack_baggy",
	[14] = "xtcbaggy",
	[15] = "lockpick",
	[16] = "electronickit",
	[17] = "trojan_usb",
	[18] = "firstaid",
	[19] = "bandage",
	[20] = "painkillers",
}

--[[ Zombie Safezone Config Settings ]]--
Config.SafeZone 				= true	-- Set to true to activate for safezones.
Config.SafeZoneRadioBlip 		= true	-- Set to true to activate safezone blips.

--[[ Zombie Safezone Location Settings ]]--
Config.SafeZoneCoords = {
	{x = 446.04, y = -993.56, z = 27.0, radio = 40},
	{x = 2708.15, y = 3492.44, z = 61.53, radio = 40},
	{x = 1465.3, y = 6348.7, z = 23.86, radio = 40},
	{x = -2133.19, y = 3263.99, z = 32.81, radio = 40}

}
