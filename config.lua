Config = {}
Config.Debug = false
Config.NoPeds = true
Config.MuteAmbience = false
Config.NotHealthRecharge = true

Config.SafeZone = true
Config.SafeZoneRadioBlip = true
Config.SafeZoneCoords = {
	{x = 446.04, y = -993.56, z = 27.0, radio = 40},
	{x = 2708.15, y = 3492.44, z = 61.53, radio = 40},
	{x = 1465.3, y = 6348.7, z = 23.86, radio = 40},
	{x = -2133.19, y = 3263.99, z = 32.81, radio = 40}

}

Config.SpawnZombie = 60 --65
Config.MinSpawnDistance = 45 -- 70
Config.MaxSpawnDistance = 60 --90
Config.DespawnDistance = 90 --115

Config.ZombieDropLoot = true
Config.RandomChance = math.random(1, 100)
Config.ItemAmount = math.random(3,5)
Config.AddtionalItem = false
Config.AddItem = 'metalscrap'
Config.AddItemAmount = math.random(1,3)

Config.ProbabilityMoneyLoot = 33 -- 3-33 = 30%
Config.ProbabilityItemLoot = 53 -- 53-43-3 = 7%
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
