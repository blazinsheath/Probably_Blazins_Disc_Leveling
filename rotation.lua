-- ProbablyEngine Rotation Packager
-- Custom Discipline Priest Rotation
-- Created on Dec 12th 2013 4:01 am

ProbablyEngine.library.register('coreHealing', {
  needsHealing = function(percent, count)
    return ProbablyEngine.raid.needsHealing(tonumber(percent)) >= count
  end,
  needsDispelled = function(spell)
    for unit,_ in pairs(ProbablyEngine.raid.roster) do
      if UnitDebuff(unit, spell) then
        ProbablyEngine.dsl.parsedTarget = unit
        return true
      end
    end
  end,
})

ProbablyEngine.rotation.register_custom(256, "Blazins Disc leveling", {

  -- Maintain these buffs
    { "21562", {
	  "player.spell(21562).exists",
	  "!player.buff(21562)"
	}}, -- Fortitude
    { "588", {
	  "player.spell(588).exists",
	  "!player.buff(588)" 
	}}, -- Inner Fire
    { "89485", "player.spell(89485).exists" }, -- Inner Focus
	{ "81700", {
	  "player.spell(81700).exists",
	  "player.buff(81661).count = 5"	
	}},  --Archangel
	{"109964", {
	  "player.spell(109964).exists",
	  "modifier.lshift" 
	}}, --Spirit Shell
	{ "596", {
	  "player.spell(596).exists",
	  "player.spell(109964).cooldown >= 50",
	  "lowest.spell(596).range"
	}, "lowest" }, --Prayer of Healing
	
   -- Mana/Survival
  
	{ "123040", { --Mindbender
	  "player.spell(123040).exists",
	  "player.mana < 95",
	  "target.spell(123040).range"
	}, "target" },
	{ "34433", { --Shadowfiend
	  "player.spell(34433).exists",	
      "player.mana < 95",	  
      "target.spell(34433).range"
    }, "target" },	
	{ "14914", { -- Power Word: Solace
	  "player.spell(14914).exists",
	  "player.spell(129250).cooldown < .001",
	  "target.spell(14914).range" 
	}, "target" },
	{ "19236", { --Desperate Prayer
	  "player.spell(19236).exists",
	  "player.health <= 20" 
	}, "Player" },
	
	--Agro
	{ "586", {
	  "player.spell(586).exists",
	  "target.threat >= 80" 
	}}, -- Fade

   --tank
    { "17", { --Power Word: Shield
      "!tank.debuff(6788).any",
	  "!tank.buff(17).any",
	  "tank.health <= 100",
	  "tank.spell(17).range"
	}, "tank" },
	{ "33076", { --Prayer of Mending
	  "player.spell(33076).exists",
	  "tank.health <= 95",
	  "tank.spell(33076).range"
	}, "tank" },
	{ "139", { --Renew
	  "player.spell(139).exists",
	  "!tank.buff(139)", 
	  "tank.health < 90",
	  "tank.spell(139).range"
	}, "tank" },
	{ "2061", { --Flash Heal before atonement
	  "player.spell(2061).exists",
	  "!player.spell(81749).exists",
	  "!player.moving",
	  "tank.health <= 80",
	  "target.spell(2061).range"
	}, "tank" },
	{ "2061", { --Flash Heal
	  "player.spell(2061).exists",
	  "player.spell(81749).exists",
	  "!player.moving",
	  "tank.health <= 30",
	  "target.spell(2061).range"
	}, "tank" },
	{ "108968", { --Void Shift
	  "player.spell(108968).exists",
	  "player.health >= 80",
	  "tank.health <= 25",
	  "tank.spell(108968).range"
	}, "tank" },
	
   --healing
   { "596", { --Prayer of Healing
      "player.spell(596).exists",
	  "!player.moving",
	  "@coreHealing.needsHealing(80, 4)",
	  "lowest.spell(596).range"
	}, "lowest" },
    { "47540", { --Penance before atonement
	  "player.spell(47540).exists",
	  "!player.spell(81749).exists",
	  "lowest.health <= 80",
	  "lowest.spell(47540).range"
	}, "lowest" },
	{ "47540", { --Penance
	  "player.spell(47540).exists",
	  "player.spell(81749).exists",
	  "lowest.health <= 80",
	  "lowest.spell(47540).range"
	}, "lowest" },
    { "2061", { --Flash Heal before atonement
	  "player.spell(2061).exists",
	  "!player.spell(81749).exists",
	  "!player.moving",
	  "lowest.health <= 70",
	  "lowest.spell(2061).range"
	}, "lowest" },
	{ "2061", { --Flash Heal
	  "player.spell(2061).exists",
	  "player.spell(81749).exists",
	  "!player.moving",
	  "lowest.health <= 25",
	  "lowest.spell(2061).range"
	}, "lowest" },
	{ "17", { --Power Word: Shield
	  "player.spell(17).exists",
	  "!lowest.debuff(6788)", --Weakend Soul
	  "!lowest.buff(17).any",
	  "lowest.health <= 50",
	  "lowest.spell(17).range"
	}, "lowest" },
	{ "2060", { --Greater Healing
	  "player.spell(2060).exists",
	  "!player.moving",
	  "lowest.health <= 60",
	  "lowest.spell(2060).range"
	}, "lowest"},
	{ "32546", { --Binding Heal
	  "player.spell(32546).exists",
	  "!player.moving",
	  "lowest.health <= 40",
	  "lowest.spell(32546).range"
	}, "lowest"},
	{ "32546", { --Binding Heal
	  "player.spell(32546).exists",
	  "!player.moving",
	  "player.health <= 70",
	  "lowest.spell(32546).range"
	}, "lowest" },  
	{ "139", { --Renew
	  "player.spell(139).exists",
	  "!lowest.buff(139)", 
	  "lowest.health <= 50",
	  "lowest.spell(139).range"
	}, "lowest"},
	{ "62618", {
	  "player.spell(62618).exists",
	  "modifier.rshift"
	}, "ground" }, --Power Word: Barrier
	{ "10060", {
	  "player.spell(10060).exists",
	  "modifier.cooldowns" 
	}}, --Power Infusion
	{ "32375", {
	  "player.spell(32375).exists",
	  "modifier.rcontrol" 
	}, "ground" }, --Mass Dispel
	
  --dps
    { "589", { --Shadow Word:Pain
	  "player.spell(589).exists",
	  "player.mana > 20",
	  "target.debuff(589).duration < 2",
	  "target.spell(589).range"
	}, "target" },
	{ "14914", { --Holy Fire
      "player.spell(14914).exists",
	  "player.spell(129250).cooldown < .001",
	  "target.spell(14914).range" 
	}, "target" },
    { "47540", { --Penance 
	  "player.spell(47540).exists",
      "player.mana > 20",	  
	  "target.spell(47540).range"
	}, "target" },
	{ "585", {
	  "player.spell(585).exists",
	  "player.mana > 20",
	  "target.spell(585).range" 
	}, "target" },	--Smite
	{ "!/target [target=focustarget, harm, nodead]", "!target.exists" },
	{ "!/target [target=focustarget, harm, nodead]", "target.range > 40" },

},{	
   
  -- Maintain these buffs
    { "21562", {
	  "player.spell(21562).exists",
	  "!player.buff(21562)"
	}}, -- Fortitude
    { "588", {
	  "player.spell(588).exists",
	  "!player.buff(588)" 
	}}, -- Inner Fire
	
})

ProbablyEngine.rotation.register_custom(256, "Blazins Disc lvl solo", {	

  -- Maintain these buffs
    { "21562", {
	  "player.spell(21562).exists",
	  "!player.buff(21562)"
	}}, -- Fortitude
    { "588", {
	  "player.spell(588).exists",
	  "!player.buff(588)" 
	}}, -- Inner Fire
	{ "81700", {
	  "player.spell(81700).exists",
	  "player.buff(81661).count = 5"	
	}},  --Archangel
	

  --Dispel
    { "527", {
	  "player.spell(527).exists",
	  "player.dispellable(527)"
	}, "player" }, --Purify
	
  -- Mana
	{ "123040", { --Mindbender
	  "player.spell(123040).exists",
	  "player.mana < 85",
	  "target.spell(123040).range"
	}, "target" },
	{ "34433", { --Shadowfiend
	  "player.spell(34433).exists",
      "player.mana < 85",  
      "target.spell(34433).range" 
    }, "target" },	
	
  --Attonement
    { "17", { --Power Word Shield
	  "player.spell(17).exists",
      "!player.debuff(6788)",
	  "!player.buff(17).any",
	  "player.health <= 60"
	}},
	{ "2061", {  --Flash Heal before atonement
	  "player.spell(2061).exists",
	  "!player.spell(81749).exists",
	  "!player.moving",
	  "player.health <= 50",
	}, "Player" },
	{ "2061", {  --Flash Heal 
	  "player.spell(2061).exists",
	  "player.spell(81749).exists",
	  "!player.moving",
	  "player.health <= 35",
	}, "Player" }, 
	{ "589", { --Shadow Word:Pain
	  "player.spell(589).exists",
	  "!player.moving",
	  "target.debuff(589).duration < 2",
	  "target.spell(589).range"
	}, "target" },
	{ "14914", { -- Power Word: Solace
	  "player.spell(14914).exists",
	  "!player.moving",
	  "player.spell(129250).cooldown < .001",
	  "target.spell(14914).range" 
	}, "target" },
	{ "14914", { --Holy Fire
	  "player.spell(14914).exists",
	  "!player.moving",
	  "player.spell(129250).cooldown < .001",
	  "target.spell(14914).range" 
	}, "target" },
	{ "47540", { --Penance 
	   "player.spell(47540).exists",
	   "!player.moving",
	   "target.health >= 20",
	   "target.spell(47540).range"
	}, "target" },
	{ "585", {
	  "player.spell(585).exists",
	  "!player.moving",
	  "target.spell(585).range",
    }, "target" },	--Smite
	{ "589", { --Shadow Word:Pain
	  "player.spell(589).exists",
	  "player.moving",
	  "target.spell(589).range"
	}, "target" },
	
},{	
    --Out of combat buffs/heals
    { "21562", {
	 "player.spell(21562).exists",
	 "!player.buff(21562)" 
	}}, --Fortitude
    { "588", {
	 "player.spell(588).exists",
	 "!player.buff(588)" 
	}}, --Inner Focus
	{ "47540", {
	 "player.spell(47540).exists",
	 "spell(47540).range",
	 "player.health < 100" 
	}}, --Penance    

})