local memory = {}

local memoryNames = {
	setting = {
		text_speed = 0x0D3D,
		battle_animation = 0x0D3E,
		battle_style = 0x0D3F,
		yellow_bitmask = 0x1354,
	},
	menu = {
		settings_row = 0x0C24,
		column = 0x0C25,
		row = 0x0C26,
		current = 0x1FFC,
		main_current = 0x0C27,
		input_row = 0x0C2A,
		size = 0x0C28,
		pokemon = 0x0C51,
		shop_current = 0x0C52,
		transaction_current = 0x0F8B,
		selection = 0x0C30,
		selection_mode = 0x0C35,
		scroll_offset = 0x0C36,
		text_input = 0x04B6,
		text_length = 0x0EE9,
		main = 0x1FF5,
	},
	player = {
		name = 0x1158,
		name2 = 0x1159,
		moving = 0x1528,
		x = 0x1362,
		y = 0x1361,
		facing = 0x152A,
		repel = 0x10DB,
		party_size = 0x1163,
	},
	game = {
		map = 0x135E,
		frames = 0x1A45,
		battle = 0x1057,
		textbox = 0x0FC4,
	},
	shop = {
		transaction_amount = 0x0F96,
	},
	progress = {
		trashcans = 0x1773,
	},
	pokemon = {
		exp1 = 0x1179,
		exp2 = 0x117A,
		exp3 = 0x117B,
	},
	battle = {
		confused = 0x106B,
		turns = 0x1067,
		text = 0x1125,
		menu = 0x0C50,
		accuracy = 0x0D1E,
		x_accuracy = 0x1063,
		disabled = 0x0CEE,
		paralyzed = 0x1018,

		opponent_move = 0x0FEE,
		critical = 0x105E,

		opponent_bide = 0x106F,
		opponent_id = 0x0FE5,
		opponent_atk_def_iv = 0x0ff1,
		opponent_spd_scl_iv = 0x0ff2,
		opponent_level = 0x0FF3,
		opponent_type1 = 0x0FEA,
		opponent_type2 = 0x0FEB,

		our_id = 0x1014,
		our_status = 0x1018,
		our_level = 0x1022,
		our_type1 = 0x1019,
		our_type2 = 0x101A,
	},
}

local doubleNames = {
	pokemon = {
		attack = 0x117E,
		defense = 0x1181,
		speed = 0x1183,
		special = 0x1185,
	},
	battle = {
		opponent_hp = 0x0FE6,
		opponent_max_hp = 0x0FF4,
		opponent_attack = 0x0FF6,
		opponent_defense = 0x0FF8,
		opponent_speed = 0x0FFA,
		opponent_special = 0x0FFC,

		our_hp = 0x1015,
		our_max_hp = 0x1023,
		our_attack = 0x1025,
		our_defense = 0x1027,
		our_speed = 0x1029,
		our_special = 0x102B,
	},
}

local function raw(value)
	return mainmemory.readbyte(value)
end
memory.raw = raw

function memory.string(first, last)
	local a = "ABCDEFGHIJKLMNOPQRSTUVWXYZ():;[]abcdefghijklmnopqrstuvwxyz?????????????????????????????????????????-???!.????????*?/.?0123456789"
	local str = ""
	while first <= last do
		local v = raw(first) - 127
		if v < 1 then
			return str
		end
		str = str..string.sub(a, v, v)
		first = first + 1
	end
	return str
end

function memory.double(section, key)
	local first = doubleNames[section][key]
	return raw(first) + raw(first + 1)
end

function memory.value(section, key)
	local memoryAddress = memoryNames[section]
	if (key) then
		memoryAddress = memoryAddress[key]
	end
	return raw(memoryAddress)
end

return memory
