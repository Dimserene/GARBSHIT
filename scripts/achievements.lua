return {
SMODS.Atlas({
	key = "garb_achievements",
	path = "garb_achievements.png",
	px = 66,
	py = 66
}),

SMODS.Achievement({
	key = "corr_upgrade",
	bypass_all_unlocked = true,
	atlas = "garb_achievements",
	-- reset_on_startup = true,
	unlock_condition = function(self, args)
		if args.type == "corrupted" then
			return true
		end
	end
}),

SMODS.Achievement({
	key = "criticalfail",
	bypass_all_unlocked = true,
	atlas = "garb_achievements",
	-- reset_on_startup = true,
	unlock_condition = function(self, args)
		if args.type == "criticalfail" then
			return true
		end
	end
}),

SMODS.Achievement({
	key = "surged",
	bypass_all_unlocked = true,
	atlas = "garb_achievements",
	-- reset_on_startup = true,
	unlock_condition = function(self, args)
		if args.type == "surged" then
			return true
		end
	end
}),

SMODS.Achievement({
	key = "rocking",
	bypass_all_unlocked = true,
	atlas = "garb_achievements",
	-- reset_on_startup = true,
	unlock_condition = function(self, args)
		if args.type == "rocking" then
			return true
		end
	end
}),

SMODS.Achievement({
	key = "snowedin",
	bypass_all_unlocked = true,
	atlas = "garb_achievements",
	-- reset_on_startup = true,
	unlock_condition = function(self, args)
		if args.type == "snowedin" then
			return true
		end
	end
}),

SMODS.Achievement({
	key = "jimboss",
	bypass_all_unlocked = true,
	atlas = "garb_achievements",
	-- reset_on_startup = true,
	unlock_condition = function(self, args)
		if args.type == "mustdie" then
			return true
		end
	end
}),


SMODS.Achievement({
	key = "regicide",
	bypass_all_unlocked = true,
	atlas = "garb_achievements",
	pos = { x = 2, y = 0 },
	-- reset_on_startup = true,
	hidden_name = true,
	hidden_text = true,
	unlock_condition = function(self, args)
		if args.type == "regicide" then
			return true
		end
	end
}),

SMODS.Achievement({
	key = "neverpunished",
	bypass_all_unlocked = true,
	atlas = "garb_achievements",
	pos = { x = 2, y = 0 },
	-- reset_on_startup = true,
	hidden_name = true,
	hidden_text = true,
	unlock_condition = function(self, args)
		if args.type == "nvpunished" then
			return true
		end
	end
}),
}