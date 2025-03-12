--- STEAMODDED HEADER
--- MOD_NAME: Garbshit
--- MOD_ID: GARBPACK
--- MOD_AUTHOR: [garb]
--- BADGE_COLOUR: 7E5A7D
--- MOD_DESCRIPTION: Garb's silly collection of good and bad thingamajigs.
--- PREFIX: garb
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-1418a]

----------------------------------------------
------------MOD CODE -------------------------

config = SMODS.current_mod.config
garb_enabled = copy_table(config)


SMODS.current_mod.optional_features = function()
  return { cardareas = { discard = true, deck = true } }
end

local function config_matching()
	for k, v in pairs(garb_enabled) do
		if v ~= config[k] then
			return false
		end
	end
	return true
end

function G.FUNCS.garb_restart()
	if config_matching() then
		SMODS.full_restart = 0
	else
		SMODS.full_restart = 1
	end
end

SMODS.current_mod.config_tab = function()
  garb_nodes = {{n=G.UIT.R, config={align = "cm"}, nodes={
    {n=G.UIT.O, config={object = DynaText({string = "Options:", colours = {G.C.WHITE}, shadow = true, scale = 0.4})}},
  }},create_toggle({label = "Teto Joker Music (Fukkireta)", ref_table = config, ref_value = "fukkireta",
  }),create_toggle({label = "Custom Title Screen (Requires Restart)", ref_table = config, ref_value = "title", callback = G.FUNCS.garb_restart,
})
}
  return {
    n = G.UIT.ROOT,
    config = {
        emboss = 0.05,
        minh = 6,
        r = 0.1,
        minw = 10,
        align = "cm",
        padding = 0.2,
        colour = G.C.BLACK
    },
    nodes = garb_nodes
  }  
end

local use_consumeable_old = Card.use_consumeable
local quadrant_hands = {"garb_blush", "garb_caliginous", "garb_ashen", "garb_pale"}
local jonklers = {"j_garb_matesprit", "j_garb_kismesis", "j_garb_auspistice", "j_garb_moirail"}
function Card:use_consumeable(area, copier)
  for i = 1, #quadrant_hands do
  if self.ability.consumeable.hand_type == "Flush" and next(find_joker(jonklers[i])) then
    update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(quadrant_hands[i], 'poker_hands'),chips = G.GAME.hands[quadrant_hands[i]].chips, mult = G.GAME.hands[quadrant_hands[i]].mult, level=G.GAME.hands[quadrant_hands[i]].level})
    level_up_hand(self, quadrant_hands[i], nil, 1)
    update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
  elseif self.ability.consumeable.hand_type == "Flush" then
    level_up_hand(self, quadrant_hands[i], true, 1)
  end
  end
  local ret = use_consumeable_old(self)
  return ret
end

function conversionTarot(hand, newcenter)
	--Animation ported from basegame Tarot
  --Hi Unstable devs I love you I ported this code over from your mod, hope you don't mind
	
	for i=1, #hand do
		local percent = 1.15 - (i-0.999)/(#hand-0.998)*0.3
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() hand[i]:flip();play_sound('card1', percent);hand[i]:juice_up(0.3, 0.3);return true end }))
	end
	delay(0.2)
	
	--Handle the conversion
	for i=1, #hand do
    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				hand[i]:set_ability(G.P_CENTERS[newcenter])
				return true end }))
	end
	
	for i=1, #hand do
		local percent = 0.85 + (i-0.999)/(#hand-0.998)*0.3
    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() hand[i]:flip();play_sound('tarot2', percent, 0.6);hand[i]:juice_up(0.3, 0.3);return true end }))
	end
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
	delay(0.5)
end

local Getid_old = Card.get_id
function Card:get_id()
  local ret = Getid_old(self)
  if ret == 12 and next(find_joker("j_garb_equality")) then ret = 13 end
  return ret
end


  -- TITLE SCREEN
if config.title then

  SMODS.Atlas({
    key = "balatro",
    path = "Logo.png",
    px = 333,
    py = 216,
    prefix_config = { key = false }
  })

  function add_card_to_title(use_key)
    local newcard = SMODS.create_card({
        set = "Joker",
        area = G.title_top,
        key = use_key,
        no_edition = true
    })
    -- recenter the title
    newcard:start_materialize({ G.C.WHITE, G.C.SECONDARY_SET.Personality }, true, 2.5)
    G.title_top:emplace(newcard)
    -- make the card look the same way as the title screen Ace of Spades
    newcard.T.scale = 1.32
  newcard.no_ui = true
end 


local main_menu_ref = Game.main_menu
Game.main_menu = function(change_context)
    local ret = main_menu_ref(change_context)
    add_card_to_title("j_garb_ratboy")
    G.title_top.T.w = G.title_top.T.w * 1.7675 * 1.2
    G.title_top.T.x = G.title_top.T.x - 0.8 * 1.8
    G.SPLASH_BACK:define_draw_steps({ {
        shader = 'splash',
        send = {
            { name = 'time',       ref_table = G.TIMERS, ref_value = 'REAL_SHADER' },
            { name = 'vort_speed', val = 0.4 },
            { name = 'colour_1',   ref_table = G.C,      ref_value = 'GARB_T2' },
            { name = 'colour_2',   ref_table = G.C,      ref_value = 'GARB_T1' },
        }
    } }) 

    return ret
end
end

assert(SMODS.load_file("scripts/achievements.lua"))()
assert(SMODS.load_file("scripts/meta.lua"))()
assert(SMODS.load_file("scripts/pokerhands.lua"))()
assert(SMODS.load_file("scripts/consumables.lua"))()
assert(SMODS.load_file("scripts/enhancements.lua"))()
assert(SMODS.load_file('scripts/unleashed_tarots.lua'))()
assert(SMODS.load_file('scripts/jokers.lua'))()
assert(SMODS.load_file('scripts/decks.lua'))()

