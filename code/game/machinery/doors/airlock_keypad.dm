// Airlock with keypad
/obj/machinery/door/airlock/keypad
	door_color = COLOR_WHITE
	name = "Keypad entry airlock"
	desc = "A door with a keypad lock."
	assembly_type = /obj/structure/door_assembly/door_assembly_keyp

	var/saved_pass = null
	var/number_entered = null
	var/show_code = "Set password"

// On create
/obj/machinery/door/airlock/keypad/New()
	. = ..()
	req_access = list()

// On click
/obj/machinery/door/airlock/keypad/attack_hand(mob/user as mob)
	if(!istype(user, /mob/living/silicon))
		if(src.isElectrified())
			src.shock(user, 100)

	ui_interact(user)

// UI
/obj/machinery/door/airlock/keypad/interface_interact(mob/user)
	ui_interact(user)
	return TRUE

/obj/machinery/door/airlock/keypad/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	user.set_machine(src)

	var/list/data = list()
	data["show_code"] = show_code

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "keypad.tmpl", "Keypad", 200, 225)
		ui.set_initial_data(data)
		ui.open()

// Answering to UI interactions
/obj/machinery/door/airlock/keypad/OnTopic(mob/user, href_list, datum/topic_state/state)
	if(user.restrained() || (get_dist(user, src) > 1))
		return
	if(href_list["button"])
		if(!istype(user, /mob/living/silicon))
			if(isElectrified())
				shock(user, 100)
		if(href_list["button"] == "E")
			if(number_entered && length(number_entered) == 5)
				if(locked)
					if(number_entered == saved_pass)
						src.unlock()
						show_code = "UNLOCKED"
						number_entered = null

						// Unlock the airlock
						if(src.density)
							src.open()
					else
						show_code = "ERROR"
						number_entered = null
				else if(saved_pass == null)
					saved_pass = number_entered
					number_entered = null
					if(!src.density)
						src.close()
					src.lock()
					show_code = "LOCKED"
			else
				show_code = "ERROR"
		else if(href_list["button"] == "R")
			number_entered = null
			if(locked)
				show_code = "LOCKED"
			else
				if(saved_pass == null)
					show_code = "UNLOCKED"
				else
					if(!src.density)
						src.close()
					src.lock()
					show_code = "LOCKED"
		else if(number_entered == null || length(number_entered) < 5)
			if(src.locked || saved_pass == null)
				if (number_entered == null)
					number_entered = href_list["button"]
				else
					number_entered += href_list["button"]

				if(saved_pass == null)
					show_code = number_entered
				else
					if(length(number_entered) == 1)
						show_code = "*"
					else
						show_code += "*"
			else
				show_code = "UNLOCKED"

	updateUsrDialog()