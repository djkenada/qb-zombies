--[[ Default Config Settings ]]--
Config = {}
Config.Debug 				= true-- Set to true for debuging.
Config.NoPeds 				= true					-- Set to true for no peds.
Config.MuteAmbience 			= false					-- Set to true to mute ambience.
Config.NotHealthRecharge 		= true					-- Set true to not all health auto recharge.

--[[ Zombie Spawn Config Settings ]]--
Config.SpawnZombie 				= 50					-- Number of zombies to spawn per player.
Config.MinSpawnDistance 		= 30 					-- Minimum distance zombies spawn from player.
Config.MaxSpawnDistance 		= 100 					-- Max distance zombies spawn from player.
Config.DespawnDistance 			= 200 					-- How far away the zombies spawn.


--[[ Zombie Loot Config Settings ]]--
Config.ZombieDropLoot 			= true  				-- For zombies to drop loot, set to true.
Config.RandomChance 			= math.random(1, 100)  			-- Random number for giveaway chance.
Config.ItemAmount 				= math.random(1,10)				-- Random number for the ammout of item given.
Config.Parts 					= false  				-- For zombies to drop loot, set to true.
Config.PartItemAmount 			= math.random(1,5) 			-- Random number for the ammout of item given.
Config.AddtionalItem 			= false	 				-- Set to true to give extra item on loot.
Config.AddItem 					= 'ammo' 				-- Extra item to give player.
Config.AddItemAmount 			= 10 					-- Random number for the ammout of extra item given.
Config.ProbabilityMoneyLoot 		= 0 					-- 33 = 30%
Config.ProbabilityItemLoot 		= 35					-- 53-33 = 20%

--[[ Zombie Loot Items Config Settings ]]--
Config.Items = {
	[1] = "water_bottle",
	[2] = "sandwich",
	[3] = "ifaks",
	[4] = "coffee",
	[5] = "bandage",
	[6] = "painkillers",
	[7] = "pistol_ammo",
	[8] = "smg_ammo",
	[9] = "rifle_ammo",
}

--[[ Zombie Body Part Config Settings ]]--
Config.ZombieParts = {
	[1] = "zombie_brain",
	[2] = "zombie_heart",
	[3] = "zombie_lungs",
	[4] = "zombie_arm",
	[5] = "zombie_foot",	
}

--[[ Zombie Safezone Config Settings ]]--
Config.SafeZone 			= true					-- Set to true to activate for safezones.
Config.SafeZoneRadioBlip 		= true					-- Set to true to activate safezone blips.

--[[ Zombie Safezone Location Settings ]]--
Config.SafeZoneCoords = {

	{x = 322.46, y = -597.27, z = 43.28, radio = 40}, -- PillBox Hospital
	{x = -45.65, y = -1098.24, z = 26.42, radio = 40}, -- PDM Motorsports
	{x = -350.74, y = -1567.49, z = 25.22, radio = 30}, -- Sell Resources Garbage Dump	
	{x = 446.04, y = -993.56, z = 27.0, radio = 40}, -- MRPD
	{x = 1443.86, y = 6348.47, z = 23.86, radio = 40}, -- Mount Chiliad Commune
	{x = -454.3, y = 5996.25, z = 31.34, radio = 25}, -- Paleto PD
	{x = 1769.44, y = 3326.63, z = 31.34, radio = 40}, -- FLYWHEELS

}
