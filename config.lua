--[[ Default Config Settings ]]--
Config = {}
Config.Debug 				= false					-- Set to true for debuging.
Config.NoPeds 				= true					-- Set to true for no peds.
Config.MuteAmbience 			= true					-- Set to true to mute ambience.
Config.NotHealthRecharge 		= true					-- Set true to not all health auto recharge.

--[[ Zombie Spawn Config Settings ]]--
Config.SpawnZombie 			= 5					-- Number of zombies to spawn per player.
Config.MinSpawnDistance 		= 30 					-- Minimum distance zombies spawn from player.
Config.MaxSpawnDistance 		= 50 					-- Max distance zombies spawn from player.
Config.DespawnDistance 			= 60 					-- How far away the zombies spawn.


--[[ Zombie Loot Config Settings ]]--
Config.ZombieDropLoot 			= true  				-- For zombies to drop loot, set to true.
Config.RandomChance 			= math.random(1, 100)  			-- Random number for giveaway chance.
Config.ItemAmount 			= 1 					-- Random number for the ammout of item given.
Config.Parts 				= true  				-- For zombies to drop loot, set to true.
Config.PartItemAmount 			= math.random(1,5) 			-- Random number for the ammout of item given.
Config.AddtionalItem 			= true	 				-- Set to true to give extra item on loot.
Config.AddItem 				= 'firstaid' 				-- Extra item to give player.
Config.AddItemAmount 			= 1 					-- Random number for the ammout of extra item given.
Config.ProbabilityMoneyLoot 		= 33 					-- 33 = 30%
Config.ProbabilityItemLoot 		= 53 					-- 53-33 = 20%

--[[ Zombie Loot Items Config Settings ]]--
Config.Items = {
	[1] = "evidence_briefcase",
	[2] = "evidence_documents",
	[3] = "evidence_samples",
	[4] = "evidence_usb",
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
