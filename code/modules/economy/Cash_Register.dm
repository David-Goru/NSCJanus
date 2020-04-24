// Define cash register object
/obj/machinery/cashregister
	name = "\improper Cash register"
	desc = "Cash register description"
	icon = 'icons/obj/cashregister.dmi'
	icon_state = "cashregister_off"
	anchored = 1
	use_power = 1
	idle_power_usage = 10 // To be changed
	active_power_usage = 20 // To be changed
	power_channel = EQUIP
	//layer = ABOVE_WINDOW_LAYER
	clicksound = "button"
	clickvol = 30

	var/panel_state = 0 // 0 for closed, 1 for open
	var/is_powered = 0
	var/cashregister_name = "Default cash register"
	var/transaction_locked = 0 // Still scanning (0), or time to pay (1)?
	var/transaction_total = 0 // Total transaction price
	var/list/transaction_items = list() // To store items information (price, name, item...)
	var/access_code = 0 // For changing account or locking the cash register
	var/obj/item/weapon/cashregisterscanner/linked/scanner // Cash register's scanner
	var/mode = 1 // 0 for close screen, 1 for general screen, 2 for items with prices list screen, 3 for items scanned list screen, 4 for settings, 5 for confirmations, 6 for cash storage
	var/area/shop/shop_area = null
	var/datum/money_account/linked_account = null
	var/password = null

	var/list/thalers // Cash stored at the cash register

	// Pretty UI
	var/static/button_examine = image(icon = 'icons/buttons.dmi', icon_state = "button_examine")
	var/static/button_open_cash_register = image(icon = 'icons/buttons.dmi', icon_state = "button_use")
	var/static/button_open_cash_storage = image(icon = 'icons/buttons.dmi', icon_state = "button_cash")
	var/static/button_turn_off = image(icon = 'icons/buttons.dmi', icon_state = "button_turn_off")
	var/static/button_point = image(icon = 'icons/buttons.dmi', icon_state = "button_point")
	var/static/button_look_at = image(icon = 'icons/buttons.dmi', icon_state = "button_look_at")


// Initialize cash register
/obj/machinery/cashregister/Initialize()
	. = ..()

	// Create and attach scanner
	scanner = new(src, src)

	// Set cash list
	var/item/thaler/A = new(1)
	var/item/thaler/B = new(10)
	var/item/thaler/C = new(20)
	var/item/thaler/D = new(50)
	var/item/thaler/E = new(100)
	var/item/thaler/F = new(200)
	var/item/thaler/G = new(500)
	var/item/thaler/H = new(1000)

	thalers = list(A,B,C,D,E,F,G,H)


	update_icon()

// Destroy cash register (and scanner)
/obj/machinery/cashregister/Destroy()
	. = ..()
	QDEL_NULL(scanner)

// Update cash register sprite
/obj/machinery/cashregister/on_update_icon()
	var/list/new_overlays = list()

	if(is_powered)
		icon_state = "cashregister"
	else
		icon_state = "cashregister_off"

	if(scanner)
		if(scanner.loc == src)
			new_overlays += "cashregister-scanner"

	overlays = new_overlays

// Examine cash register
/obj/machinery/cashregister/examine(mob/user)
	. = ..()
	to_chat(user, "Cash register examine text.")

// Check if the player has clicked the cash register
/obj/machinery/cashregister/CtrlClick(var/mob/user)
	if (scanner.loc == src)
		toggle_scanner()

// I don't know what this is for
/obj/machinery/cashregister/MouseDrop()
	if(ismob(src.loc))
		if(!CanMouseDrop(src))
			return
		var/mob/M = src.loc
		if(!M.unEquip(src))
			return
		src.add_fingerprint(usr)
		M.put_in_any_hand_if_possible(src)

// When cash register is clicked with something on hand
/obj/machinery/cashregister/attackby(obj/item/device/W, mob/user, params)
	if(W == scanner)
		reattach_scanner(user)
	else if (ispath(W, /obj/item/weapon/cashregisterscanner/))
		scanner = W
		reattach_scanner(user)
	else if((obj_flags & OBJ_FLAG_ANCHORABLE) && isWrench(W))
		wrench_floor_bolts(user)
		return
	else if(isScrewdriver(W))
		panel_state = !panel_state
		if (panel_state)
			to_chat(user, "The cash register panel is now open.")
		else
			to_chat(user, "The cash register panel is now closed.")
	else if(isMultitool(W) && panel_state == 1)
		var/shop_id = (input(user,"Shop ID","Set shop ID","") as null|num)
		for(var/area/shop/s in shop_areas_list)
			if(s.id == shop_id)
				shop_area = s
				to_chat(user, "Cash register linked to shop with ID [shop_id]")
	else if(istype(W, /obj/item/weapon/card))
		if(transaction_total > 0)
			var/obj/item/weapon/card/id/idcard = W
			var/datum/money_account/D = get_account(idcard.associated_account_number)
			if(D)
				if(D.money >= transaction_total)
					D.withdraw(transaction_total, "Purchase at [shop_area.institution_name]", shop_area.institution_name)
					for(var/item/itemtemplate/I in transaction_items)
						shop_area.items_prices.Remove(I)
					transaction_items = list()
					transaction_total = 0
				else
					to_chat(user, "Not enough money.")
			else
				to_chat(user, "Error. No account found.")
		else
			to_chat(user, "It seems like there's nothing to pay for.")
	else if(istype(W, /obj/item/weapon/spacecash))
		var/obj/item/weapon/spacecash/thaler = W
		if(user.unEquip(thaler, src))
			for(var/item/thaler/t in thalers)
				if(t.value == thaler.worth)
					t.amount++
	else
		return ..()

// When cash storage is clicked (for UI)
/obj/machinery/cashregister/attack_hand(mob/user)
	// Define the buttons
	var/list/options = list()
	options["examine"] = button_examine
	options["open_cash_register"] = button_open_cash_register
	options["open_cash_storage"] = button_open_cash_storage
	options["turn_off"] = button_turn_off
	options["point"] = button_point
	options["look_at"] = button_look_at

	var/choice = show_object_menu(user, src, options, require_near = !issilicon(user))

	switch(choice)
		if ("examine")
			examine(user)
		if("open_cash_register")
			src.add_fingerprint(user)
			..()
		if("open_cash_storage")
			src.add_fingerprint(user)
			mode = 6
			..()
		if("turn_off")
			mode = 0
			ui_interact(user)
		if("point")
			// Add point emote
			user.visible_message("[user] points to the cash register.", "You point to the cash register", null)
		if("look_at")
			user.visible_message("[user] stares at the cash register.", "You stare at the cash register", null)

// Item object for the items list
/item/itemtemplate
	var/obj/item/item
	var/name
	var/price
	var/item_id

// Cash object
/item/thaler
	var/value
	var/amount = 0

/item/thaler/New(var/val)
	value = val

// Check if user opens UI
/obj/machinery/cashregister/interface_interact(mob/user)
	ui_interact(user)
	return TRUE

// Open cash register window
/obj/machinery/cashregister/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	user.set_machine(src)
	is_powered = 1
	on_update_icon()

	var/list/data = list()

	// Mode and title
	data["mode"] = mode
	data["title"] = "Cash register"
	data["text"] = ""
	if(scanner.loc == src)
		data["hasscanner"] = 1
	else
		data["hasscanner"] = 0

	if(linked_account == null)
		data["hasaccount"] = 0
	else
		data["hasaccount"] = 1

	if(mode == 0) // Close computer
		src.add_fingerprint(user)
		is_powered = 0
		on_update_icon()
		ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
		if(ui)
			ui.close()
		mode = 1
		return
	else if(mode == 1) // Main screen
		data["text"] = "Main screen of the cash register"
		if (shop_area == null)
			data["hasshop"] = 0
		else
			data["hasshop"] = 1
	else if(mode == 2) // Prices list screen
		data["text"] = "Prices list"

		var/products[0]
		for(var/item/itemtemplate/I in shop_area.items_prices)
			products[++products.len] = list("name" = I.name, "price" = I.price, "item" = I.item_id)

		data["products"] = products
	else if(mode == 3) // Scanned list screen
		data["text"] = "Scanned items list"

		var/products[0]
		for(var/item/itemtemplate/I in transaction_items)
			products[++products.len] = list("name" = I.name, "price" = I.price, "item" = I.item_id)

		data["products"] = products
	else if(mode == 4)
		data["text"] = "Settings"
	else if(mode == 5)
		data["text"] = "Clean prices list confirmation"
	else if(mode == 6)
		data["text"] = "Cash"
		data["thalers"] = thalers

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "cash_register.tmpl", src.name, 400, 400)
		ui.set_initial_data(data)
		ui.open()

// Interact with the UI
/obj/machinery/cashregister/OnTopic(mob/user, href_list, datum/topic_state/state)
	if(href_list["option"])
		if(href_list["option"] == "toggleCashRegister")
			mode = 1
		else if(href_list["option"] == "togglePricesList")
			mode = 2
		else if(href_list["option"] == "toggleScannedList")
			mode = 3
		else if (href_list["option"] == "toggleSettings")
			mode = 4
		else if (href_list["option"] == "cleanInventoryQuestion")
			mode = 5
		else if (href_list["option"] == "toggleCash")
			mode = 6
		else if (href_list["option"] == "setAccount")
			var/account = input(user, "Set account", "Account number")
			var/datum/money_account/D
			D = get_account(account)

			if(D)
				var/pin = input(user, "Set pin", "Pin")
				if(pin == D.remote_access_pin)
					linked_account = D
				else
					to_chat(user, "Error: incorrect pin.")
			else
				to_chat(user, "Error: account not found.")
		else if (href_list["option"] == "cleanInventoryConfirm")
			for(var/item/itemtemplate/I in shop_area.items_prices)
				shop_area.items_prices.Remove(I)
			mode = 3
		else if(href_list["option"] == "printReceipt")
			if (transaction_items.len == 0)
				return TOPIC_HANDLED
			to_chat(usr, "*Printing receipt...*")
			return print_receipt()
		else if(href_list["option"] == "objectsPaid")
			if (transaction_items.len == 0)
				return TOPIC_HANDLED
			for(var/item/itemtemplate/I in transaction_items)
				shop_area.items_prices.Remove(I)
			transaction_items = list()
			transaction_total = 0
		else if(href_list["option"] == "shutdown")
			mode = 0
		else if(href_list["option"] == "newshop") // For testing purposes
			var/area/shop/shop_area = new()
			shop_areas_list += shop_area
		else if (href_list["option"] == "takescanner")
			toggle_scanner()
		else if (href_list["option"] == "takescanner")
			for(var/item/itemtemplate/I in transaction_items)
				if(I.item == href_list["option"]) transaction_items.Remove(I)
	else if(href_list["removeFromPrices"])
		var/remove_item_id = href_list["removeFromPrices"]
		for(var/item/itemtemplate/I in shop_area.items_prices)
			if(I.item_id == remove_item_id)
				shop_area.items_prices.Remove(I)
	else if(href_list["removeFromTransaction"])
		var/remove_item_id = href_list["removeFromTransaction"]
		for(var/item/itemtemplate/I in transaction_items)
			if(I.item_id == remove_item_id)
				transaction_items.Remove(I)
	else if(href_list["takeCash"])
		var/thaler_value = href_list["takeCash"]
		for(var/item/thaler/T in thalers)
			if(T.value == thaler_value)
				T.amount--
				spawn_money(thaler_value,src.loc,user)

	return TOPIC_REFRESH

// Print receipt
/obj/machinery/cashregister/proc/print_receipt()
	// Create paper
	var/obj/item/weapon/paper/R = new(src.loc)
	R.SetName("Receipt")

	//Temptative new manual:
	R.info += "<b>This is a ticket!!</b><br><br>"
	for(var/item/itemtemplate/I in transaction_items)
		R.info += "- [I.name] (T[I.price])<br>"
	R.info += "<br>Total price: T[transaction_total]<br>"

	// Stamp de receipt
	var/image/stampoverlay = image('icons/obj/bureaucracy.dmi')
	stampoverlay.icon_state = "paper_stamp-boss"
	if(!R.stamped)
		R.stamped = new
	R.offset_x += 0
	R.offset_y += 0
	R.ico += "paper_stamp-boss"
	R.stamped += /obj/item/weapon/stamp
	R.overlays += stampoverlay
	R.stamps += "<HR><i>This paper has been stamped by a cash register.</i>"

	return TOPIC_HANDLED

// Scanner stuff
// Take scanner
/obj/machinery/cashregister/verb/toggle_scanner()
	set name = "Toggle scanner"
	set category = "Object"

	var/mob/living/carbon/human/user = usr
	if(!scanner)
		to_chat(user, "<span class='warning'>The scanner is missing.</span>")
		return

	if(scanner.loc != src)
		reattach_scanner(user)
		return

	if(!usr.put_in_hands(scanner)) //Detach the scanner into the user's hands
		to_chat(user, "<span class='warning'>You need a free hand to hold the scanner!</span>")
	update_icon()

// Reattach scanner to cash register
/obj/machinery/cashregister/proc/reattach_scanner(mob/user)
	if(!scanner) return

	if(ismob(scanner.loc))
		var/mob/M = scanner.loc
		if(M.drop_from_inventory(scanner, src))
			to_chat(user, "<span class='notice'>\The [scanner] snap back into the cash register.</span>")
	else
		scanner.forceMove(src)

	update_icon()

// Define scanner object
/obj/item/weapon/cashregisterscanner
	name = "Cash register scanner"
	desc = "Scanner description."
	icon = 'icons/obj/cashregister.dmi'
	icon_state = "scanner"
	item_state = "scanner"
	force = 2
	throwforce = 6
	w_class = ITEM_SIZE_LARGE

	var/mode = 0
	var/price

// Scanner constructor
/obj/item/weapon/cashregisterscanner/linked
	var/obj/machinery/cashregister/base_unit

/obj/item/weapon/cashregisterscanner/linked/New(newloc, obj/machinery/cashregister/C)
	base_unit = C
	..(newloc)

/obj/item/weapon/cashregisterscanner/linked/Destroy()
	if(base_unit)
		if(base_unit.scanner == src)
			base_unit.scanner = null
			base_unit.update_icon()
		base_unit = null
	return ..()

// Check if scanner can be used
/obj/item/weapon/cashregisterscanner/linked/proc/can_use(mob/user, mob/M)
	if(base_unit.shop_area == null)
		return 0
	return 1

// Check if object can be scanned
/obj/item/weapon/cashregisterscanner/proc/can_scan(obj/item/I)
	// Check if item in list of scannable items

	return 1

// This was set on the handlabeler too (?)
/obj/item/weapon/cashregisterscanner/attack()
	return

// Use scanner
/obj/item/weapon/cashregisterscanner/linked/afterattack(atom/A, mob/user as mob, proximity)
	if(!proximity)
		return
	if(A == loc)	// If placing the labeller into something (e.g. backpack)
		return		// don't set a label

	if(base_unit.shop_area == null)
		to_chat(usr, "You need to set up the cash register first.")
		return

	if(mode == 0) // Set prices mode
		if(!price)
			to_chat(user, "<span class='notice'>No price set.</span>")
			return

		var/item/itemtemplate/I = null
		for(var/item/itemtemplate/t in base_unit.shop_area.items_prices)
			if(t.item == A)
				I = t
		if (I == null)
			I = new()
			I.item = A
			I.item_id = "Item [base_unit.shop_area.item_id_counter]"
			base_unit.shop_area.item_id_counter++
		I.name = A.name
		I.price = price

		playsound(A.loc, 'sound/machines/dotprinter.ogg', 50, 1)
		to_chat(user, "Priced [A.name] with T[price].")
		base_unit.shop_area.items_prices += I
	else // Scan item mode
		if (can_use(user) && can_scan(A))
			var/item/itemtemplate/I = null
			for(var/item/itemtemplate/t in base_unit.shop_area.items_prices)
				if(t.item == A) I = t

			if(I != null)
				var/newscan = 1
				for(var/item/itemtemplate/s in base_unit.transaction_items)
					if(s == I)
						newscan = 0
				if (newscan)
					base_unit.transaction_total += I.price
					base_unit.transaction_items += I
					playsound(A.loc, 'sound/machines/quiet_beep.ogg', 50, 1)
					to_chat(user, "*Beep*")
				else
					to_chat(user, A.name + " already scanned.")
			else
				to_chat(user, A.name + " hasn't been priced.")
		else
			to_chat(user, "Can't scan " + A.name)

// Click on scanner to set prices
/obj/item/weapon/cashregisterscanner/attack_self(mob/user as mob)
	var/newprice = (input(user,"Price?","Set price","") as null|num)
	if(!newprice)
		to_chat(user, "<span class='notice'>Invalid price.</span>")
		return
	price = newprice
	to_chat(user, "<span class='notice'>You set the price ([price]).</span>")

// Change scanner mode
/obj/item/weapon/cashregisterscanner/CtrlClick(var/mob/user)
	Change_mode()

/obj/item/weapon/cashregisterscanner/verb/Change_mode()
	if (mode == 0)
		mode = 1
		to_chat(usr, "Changed to scanner mode.")
	else
		mode = 0
		to_chat(usr, "Changed to set price mode.")