function user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal','Acc')
	state.CastingMode:options('Normal','Resistant','AoE')
	state.IdleMode:options('Normal','NoRefresh','DT')
	state.Weapons:options('None','Aeneas','DualWeapons','DualNaegling','DualTauret','DualNukeWeapons')
	state.UnlockWeapons = M(true, 'Unlock Weapons')

	gear.kali_idle = {name="Kali",augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}}
	gear.kali_macc = {name="Kali",augments={'DMG:+15','CHR+15','Mag. Acc.+15',}}

	gear.fc_jse_cape = {name="Intarabus's Cape",augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}}
	gear.stp_jse_cape = {name="Intarabus's Cape",augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}}
	gear.str_jse_back = {name="Intarabus's Cape",augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	gear.dex_jse_back = {name="Intarabus's Cape",augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}

	autows = 'Savage Blade'

	-- Adjust this if using the Terpander (new +song instrument)
	info.ExtraSongInstrument = 'Blurred Harp +1'
	-- How many extra songs we can keep from Daurdabla/Terpander
	info.ExtraSongs = 1
	
	-- Set this to false if you don't want to use custom timers.
	state.UseCustomTimers = M(false, 'Use Custom Timers')
	
	-- Additional local binds
	send_command('bind ^` gs c cycle ExtraSongsMode')
	send_command('bind !` input /ma "Chocobo Mazurka" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !q gs c weapons NukeWeapons;gs c update')
	send_command('bind ^q gs c weapons Swords;gs c update')

	select_default_macro_book()
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Weapons sets
	sets.weapons.Aeneas = {main="Aeneas",sub="Genmei Shield"}
	sets.weapons.DualWeapons = {main="Aeneas",sub="Blurred Knife +1"}
	sets.weapons.DualNaegling = {main="Kaja Sword",sub="Kaja Knife"} --main="Kaja Sword",sub="Kaja Knife"
	sets.weapons.DualTauret = {main="Tauret",sub="Blurred Knife +1"}
	sets.weapons.DualNukeWeapons = {main="Malevolence",sub="Malevolence"}

	sets.buff.Sublimation = {waist="Embla Sash"}
	sets.buff.DTSublimation = {waist="Embla Sash"}
	
	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {main=gear.kali_idle,sub="Genmei Shield",range="Gjallarhorn",
		head="Welkin Crown",neck="Voltsurge Torque",ear1="Loquac. Earring",ear2="Etiolation Earring",
		body="Inyanga Jubbah +2",hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Weather. Ring",
		back=gear.fc_jse_cape,waist="Embla Sash",legs="Aya. Cosciales +2",feet="Telchine Pigaches"}

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {feet="Vanya Clogs"})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})
	
	sets.precast.FC.BardSong = {main=gear.kali_idle,sub="Genmei Shield",range="Gjallarhorn",
		head="Fili Calot +1",neck="Voltsurge Torque",ear1="Loquac. Earring",ear2="Etiolation Earring",
		body="Inyanga Jubbah +2",hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Weather. Ring",
		back=gear.fc_jse_cape,waist="Embla Sash",legs="Aya. Cosciales +2",feet="Telchine Pigaches"}

	sets.precast.FC.SongDebuff = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC.SongDebuff.Resistant = set_combine(sets.precast.FC.BardSong,{range="Gjallarhorn"})
	sets.precast.FC.Lullaby = {range="Gjallarhorn"}
	sets.precast.FC.Lullaby.Resistant = {range="Gjallarhorn"}
	sets.precast.FC['Horde Lullaby'] = {range="Gjallarhorn"}
	sets.precast.FC['Horde Lullaby'].Resistant = {range="Gjallarhorn"}
	sets.precast.FC['Horde Lullaby'].AoE = {range="Blurred Harp +1"}
	sets.precast.FC['Horde Lullaby II'] = {range="Gjallarhorn"}
	sets.precast.FC['Horde Lullaby II'].Resistant = {range="Gjallarhorn"}
	sets.precast.FC['Horde Lullaby II'].AoE = {range="Blurred Harp +1"}
		
	sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})

	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
	sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla

	-- Precast sets to enhance JAs

	sets.precast.JA.Nightingale = {feet="Bihu Slippers"}
	sets.precast.JA.Troubadour = {body="Bihu Jstcorps"}
	sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Hasty Pinion +1",
		head="Aya. Zucchetto +2",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +1",ring1="Ramuh Ring +1",ring2="Ilabrat Ring",
		back=gear.str_jse_back,waist="Grunfeld Rope",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}
		
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Ishvara Earring",ear2="Telos Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	-- Midcast Sets

	-- General set for recast times.
	sets.midcast.FastRecast = {main=gear.kali_idle,sub="Genmei Shield",range="Gjallarhorn",
		head="Welkin Crown",neck="Voltsurge Torque",ear1="Loquac. Earring",ear2="Etiolation Earring",
		body="Inyanga Jubbah +2",hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Weather. Ring",
		back=gear.fc_jse_cape,waist="Embla Sash",legs="Aya. Cosciales +2",feet="Telchine Pigaches"}

	-- Gear to enhance certain classes of songs
	sets.midcast.Ballad = {legs="Fili Rhingrave +1"}
	sets.midcast.Lullaby = {range="Gjallarhorn"}
	sets.midcast.Lullaby.Resistant = {range="Gjallarhorn"}
	sets.midcast['Horde Lullaby'] = {range="Gjallarhorn"}
	sets.midcast['Horde Lullaby'].Resistant = {range="Gjallarhorn"}
	sets.midcast['Horde Lullaby'].AoE = {range="Blurred Harp +1",hands="Brioso Cuffs +1"}
	sets.midcast['Horde Lullaby II'] = {range="Gjallarhorn"}
	sets.midcast['Horde Lullaby II'].Resistant = {range="Gjallarhorn"}
	sets.midcast['Horde Lullaby II'].AoE = {range="Blurred Harp +1",hands="Brioso Cuffs +1"}
	sets.midcast.Madrigal = {head="Fili Calot +1"}
	sets.midcast.Paeon = {}
	sets.midcast.March = {hands="Fili Manchettes +1"}
	sets.midcast['Honor March'] = set_combine(sets.midcast.March,{range="Marsyas"})
	sets.midcast.Minuet = {body="Fili Hongreline +1"}
	sets.midcast.Minne = {}
	sets.midcast.Carol = {}
	sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +1"}
	sets.midcast['Magic Finale'] = {range="Gjallarhorn"}
	sets.midcast.Mazurka = {range="Gjallarhorn"}
	

	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {main=gear.kali_macc,sub="Genmei Shield",range="Gjallarhorn",
		head="Fili Calot +1",neck="Moonbow Whistle",ear1="Gwati Earring",ear2="Bragi Earring",
		body="Fili Hongreline +1",hands="Inyan. Dastanas +2",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back=gear.fc_jse_cape,waist="Porous Rope",legs="Inyanga Shalwar +2",feet="Brioso Slippers +2"}
		
	sets.midcast.SongEffect.DW = {main=gear.kali_macc,sub=gear.kali_idle}

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = {main=gear.kali_macc,sub="Genmei Shield",range="Gjallarhorn",
		head="Inyanga Tiara +2",neck="Moonbow Whistle",ear1="Gwati Earring",ear2="Bragi Earring",
		body="Fili Hongreline +1",hands="Inyan. Dastanas +2",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back=gear.fc_jse_cape,waist="Porous Rope",legs="Inyanga Shalwar +2",feet="Brioso Slippers +2"}
		
	sets.midcast.SongDebuff.DW = {main=gear.kali_macc,sub=gear.kali_idle}

	-- For song defbuffs (accuracy primary, duration secondary)
	sets.midcast.SongDebuff.Resistant = {main=gear.kali_macc,sub="Genmei Shield",range="Gjallarhorn",
		head="Inyanga Tiara +2",neck="Moonbow Whistle",ear1="Gwati Earring",ear2="Bragi Earring",
		body="Inyanga Jubbah +2",hands="Inyan. Dastanas +2",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back=gear.fc_jse_cape,waist="Porous Rope",legs="Inyanga Shalwar +2",feet="Brioso Slippers +2"}

	-- Song-specific recast reduction
	sets.midcast.SongRecast = {main=gear.kali_macc,sub="Genmei Shield",range="Gjallarhorn",
		head="Nahtirah Hat",neck="Moonbow Whistle",ear1="Loquac. Earring",ear2="Etiolation Earring",
		body="Inyanga Jubbah +2",hands="Inyan. Dastanas +2",ring1="Metamor. Ring +1",ring2="Stikini Ring",
		back=gear.fc_jse_cape,waist="Porous Rope",legs="Inyanga Shalwar +2",feet="Telchine Pigaches"}
		
	sets.midcast.SongDebuff.DW = {}

	-- Cast spell with normal gear, except using Daurdabla instead
	sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

	-- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
	sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

	-- Other general spells and classes.
	sets.midcast.Cure = {main="Serenity",sub="Curatio Grip",ammo="Pemphredo Tathlum",
		head="Gende. Caubeen +1",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Mendi. Earring",
		body="Kaykaus Bliaut",hands="Kaykaus Cuffs",ring1="Janniston Ring",ring2="Menelaus's Ring",
		back="Tempered Cape +1",waist="Luminary Sash",legs="Carmine Cuisses +1",feet="Kaykaus Boots"}
		
	sets.midcast.Curaga = sets.midcast.Cure
		
	sets.Self_Healing = {
		--neck="Phalaina Locket",
		--hands="Buremte Gloves",
		--ring2="Kunaji Ring",
		waist="Gishdubar Sash"
	}
	sets.Cure_Received = {
		--neck="Phalaina Locket",
		--hands="Buremte Gloves",
		--ring2="Kunaji Ring",
		waist="Gishdubar Sash"
	}
	sets.Self_Refresh = {
		--back="Grapevine Cape",
		waist="Gishdubar Sash"
	}
		
	sets.midcast['Enhancing Magic'] = {main="Serenity",sub="Fulcio Grip",ammo="Hasty Pinion +1",
		head="Telchine Cap",neck="Voltsurge Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body="Telchine Chas.",hands="Telchine Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Intarabus's Cape",waist="Embla Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		neck="Nodens Gorget",
		--ear2="Earthcry Earring",
		--waist="Siegel Sash",
		--legs="Shedir Seraweels"
	})
		
	sets.midcast['Elemental Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Dosis Tathlum",
		head="C. Palug Crown",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Chironic Doublet",hands="Volte Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Sekhmet Corset",legs="Gyve Trousers",feet=gear.chironic_nuke_feet}
		
	sets.midcast['Elemental Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Dosis Tathlum",
		head="C. Palug Crown",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Chironic Doublet",hands="Volte Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Yamabuki-no-Obi",legs="Gyve Trousers",feet=gear.chironic_nuke_feet}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",hands="Hieros Mittens",
		back="Oretan. Cape +1",ring1="Haoma's Ring",ring2="Menelaus's Ring",waist="Witful Belt",feet="Vanya Clogs"})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main=gear.grioavolr_fc_staff,sub="Clemency Grip"})

	-- Resting sets
	sets.resting = {main="Chatoyant Staff",sub="Oneiros Grip",ammo="Staunch Tathlum +1",
		head="Aya. Zucchetto +2",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Ayanmo Corazza +2",hands=gear.chironic_refresh_hands,ring1="Ayanmo Ring",ring2="Inyanga Ring",
		back="Umbra Cape",waist="Flume Belt",legs="Aya. Cosciales +2",feet=gear.chironic_refresh_feet}
	
	sets.idle = {main=gear.kali_idle,sub="Genmei Shield",
		head="Aya. Zucchetto +2",neck="Loricate Torque +1",ear1="Moonshade Earring",ear2="Etiolation Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +1",ring1="Ayanmo Ring",ring2="Inyanga Ring",
		back="Kumbira Cape",waist="Flume Belt",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}
		
	sets.idle.NoRefresh = {main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Aya. Zucchetto +2",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +1",ring1="Ayanmo Ring",ring2="Inyanga Ring",
		back="Moonlight Cape",waist="Flume Belt",legs="Aya. Cosciales +2",feet="Fili Cothurnes +1"}

	sets.idle.DT = {main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Aya. Zucchetto +2",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +1",ring1="Ayanmo Ring",ring2="Inyanga Ring",
		back="Moonlight Cape",waist="Flume Belt",legs="Aya. Cosciales +2",feet="Inyan. Crackows +2"}
	
	-- Defense sets

	sets.defense.PDT = {main="Terra's Staff", sub="Umbra Strap",ammo="Staunch Tathlum +1",
		head="Aya. Zucchetto +2",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Ayanmo Corazza +2",hands=gear.chironic_refresh_hands,ring1="Ayanmo Ring",ring2="Inyanga Ring",
		back="Umbra Cape",waist="Flume Belt",legs="Assid. Pants +1",feet=gear.chironic_refresh_feet}

	sets.defense.MDT = {main="Terra's Staff", sub="Umbra Strap",ammo="Staunch Tathlum +1",
		head="Aya. Zucchetto +2",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Ayanmo Corazza +2",hands=gear.chironic_refresh_hands,ring1="Ayanmo Ring",ring2="Inyanga Ring",
		back="Umbra Cape",waist="Flume Belt",legs="Assid. Pants +1",feet=gear.chironic_refresh_feet}

	sets.Kiting = {feet="Fili Cothurnes +1"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.TPEat = {neck="Chrys. Torque"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	sets.engaged = {main="Aeneas",sub="Genmei Shield",ammo="Aurgelmir Orb +1",
		head="Aya. Zucchetto +2",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +1",ring1="Petrov Ring",ring2="Ilabrat Ring",
		back=gear.stp_jse_cape,waist="Kentarch Belt",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}
	sets.engaged.Acc = {main="Aeneas",sub="Genmei Shield",ammo="Aurgelmir Orb +1",
		head="Aya. Zucchetto +2",neck="Combatant's Torque",ear1="Digni. Earring",ear2="Brutal Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +1",ring1="Ramuh Ring +1",ring2="Ilabrat Ring",
		back=gear.stp_jse_cape,waist="Kentarch Belt",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}
	sets.engaged.DW = {main="Aeneas",sub="Blurred Knife +1",ammo="Aurgelmir Orb +1",
		head="Aya. Zucchetto +2",neck="Asperity Necklace",ear1="Suppanomimi",ear2="Brutal Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +1",ring1="Petrov Ring",ring2="Ilabrat Ring",
		back=gear.stp_jse_cape,waist="Kentarch Belt",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}
	sets.engaged.DW.Acc = {main="Aeneas",sub="Blurred Knife +1",ammo="Aurgelmir Orb +1",
		head="Aya. Zucchetto +2",neck="Combatant's Torque",ear1="Suppanomimi",ear2="Brutal Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +1",ring1="Ramuh Ring +1",ring2="Ilabrat Ring",
		back=gear.stp_jse_cape,waist="Kentarch Belt",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 1)
end

function user_job_lockstyle()
	if player.sub_job == 'RDM' or player.sub_job == 'WHM' then
		if player.equipment.main == nil or player.equipment.main == 'empty' then
			windower.chat.input('/lockstyleset 1')
		elseif res.items[item_name_to_id(player.equipment.main)].skill == 3 then --Sword in main hand.
			if res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Sword/Sword.
				windower.chat.input('/lockstyleset 1')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Sword/Dagger.
				windower.chat.input('/lockstyleset 1')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 11 then --Sword/Club.
				windower.chat.input('/lockstyleset 1')
			else
				windower.chat.input('/lockstyleset 1') --Catchall
			end
		elseif res.items[item_name_to_id(player.equipment.main)].skill == 2 then --Dagger in main hand.
			if res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Dagger/Sword.
				windower.chat.input('/lockstyleset 1')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Dagger/Dagger.
				windower.chat.input('/lockstyleset 1')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 11 then --Dagger/Club.
				windower.chat.input('/lockstyleset 1')
			else
				windower.chat.input('/lockstyleset 1') --Catchall
			end
		elseif res.items[item_name_to_id(player.equipment.main)].skill == 11 then --Club in main hand.
			if res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Club/Sword.
				windower.chat.input('/lockstyleset 1')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Club/Dagger.
				windower.chat.input('/lockstyleset 1')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 11 then --Club/Club.
				windower.chat.input('/lockstyleset 1')
			else
				windower.chat.input('/lockstyleset 1') --Catchall
			end
		end
	elseif player.sub_job == 'WHM' or state.Buff['Light Arts'] or state.Buff['Addendum: White'] then
		windower.chat.input('/lockstyleset 1')
	elseif player.sub_job == 'BLM' or state.Buff['Dark Arts'] or state.Buff['Addendum: Black'] then
		windower.chat.input('/lockstyleset 1')
	else
		windower.chat.input('/lockstyleset 1')
	end
end

function check_song()
	if state.AutoSongMode.value then
		if not buffactive.march then
			windower.chat.input('/ma "Victory March" <me>')
			tickdelay = os.clock() + 2
			return true
		elseif not buffactive.minuet then
			windower.chat.input('/ma "Valor Minuet V" <me>')
			tickdelay = os.clock() + 2
			return true
		elseif not buffactive.madrigal then
			windower.send_command('gs c set ExtraSongsMode FullLength;input /ma "Blade Madrigal" <me>')
			tickdelay = os.clock() + 2
			return true
		else
			return false
		end
	else
		return false
	end
end
