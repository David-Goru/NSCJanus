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
	var/transaction_total = 0 // Total transaction price
	var/transaction_paid = 0
	var/list/transaction_items = list() // To store items information (price, name, item...)
	var/access_code = 0 // For changing account or locking the cash register
	var/obj/item/weapon/cashregisterscanner/linked/scanner // Cash register's scanner
	var/mode = 1 // 0 for close screen, 1 for general screen, 2 for items with prices list screen, 3 for items scanned list screen, 4 for settings, 5 for confirmations, 6 for cash storage
	var/area/shop/shop_area = null
	var/datum/money_account/linked_account = null
	var/obj/machinery/cashregisterpos/linked_pos = null
	var/password = null
	var/tax = 10
	var/selected_transaction = 0

	var/list/thalers = list() // Cash stored at the cash register

	// Pretty UI
	var/static/button_examine = image(icon = 'icons/buttons.dmi', icon_state = "button_examine")
	var/static/button_open_cash_register = image(icon = 'icons/buttons.dmi', icon_state = "button_use")
	var/static/button_open_cash_storage = image(icon = 'icons/buttons.dmi', icon_state = "button_cash")
	var/static/button_shutdown = image(icon = 'icons/buttons.dmi', icon_state = "button_shutdown")
	var/static/button_point = image(icon = 'icons/buttons.dmi', icon_state = "button_point")


// Initialize cash register
/obj/machinery/cashregister/Initialize()
	. = ..()

	// Create and attach scanner
	scanner = new(src, src)

	// Set cash list
	var/item/thaler/A = new()
	A.worth = 1
	thalers += A
	var/item/thaler/B = new()
	B.worth = 10
	thalers += B
	var/item/thaler/C = new()
	C.worth = 20
	thalers += C
	var/item/thaler/D = new()
	D.worth = 50
	thalers += D
	var/item/thaler/E = new()
	E.worth = 100
	thalers += E
	var/item/thaler/F = new()
	F.worth = 200
	thalers += F
	var/item/thaler/G = new()
	G.worth = 500
	thalers += G
	var/item/thaler/H = new()
	H.worth = 1000
	thalers += H


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
			if("[s.id]" == "[shop_id]")
				shop_area = s
				to_chat(user, "Cash register linked to shop with ID [shop_id]")
				name = "\improper Cash register - " + s.institution_name
	else if(istype(W, /obj/item/weapon/card))
		pay_with_card(W, user)
	else if(istype(W, /obj/item/weapon/spacecash))
		var/obj/item/weapon/spacecash/thaler = W
		if(user.unEquip(thaler, src))
			for(var/item/thaler/t in thalers)
				if(t.worth == thaler.worth)
					t.amount++
					if(transaction_total > 0)
						transaction_paid += thaler.worth
	else
		return ..()

// When cash storage is clicked (for UI)
/obj/machinery/cashregister/attack_hand(mob/user)
	// Define the buttons
	var/list/options = list()
	options["examine"] = button_examine
	options["open_cash_register"] = button_open_cash_register
	options["open_cash_storage"] = button_open_cash_storage
	options["shutdown"] = button_shutdown
	options["point"] = button_point

	var/choice = show_object_menu(user, src, options, require_near = !issilicon(user))

	switch(choice)
		if ("examine")
			examine(user)
		if("open_cash_register")
			src.add_fingerprint(user)
			return ..()
		if("open_cash_storage")
			src.add_fingerprint(user)
			mode = 6
			return ..()
		if("shutdown")
			src.add_fingerprint(user)
			mode = 0
			return ..()
		if("point")
			user.pointed(src)

// Item object for the items list
/item/itemtemplate
	var/obj/item/item
	var/name
	var/price
	var/item_id

// Cash object
/item/thaler
	var/worth = 0
	var/amount = 0

// Transaction object
/item/shop_transaction
	var/id
	var/total_amount
	var/tax_applied
	var/items = list()
	var/name

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

	// Header
	data["PC_hasheader"] = 1
	data["PC_stationtime"] = stationtime2text()
	data["hassettings"] = 1
	data["hasback"] = 1


	// Mode and title
	data["mode"] = mode
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
		data["hasback"] = 0
		data["text"] = "Main screen"
		if (shop_area == null)
			data["hasshop"] = 0
		else
			data["hasshop"] = 1
	else if(mode == 2) // Inventory screen
		data["text"] = "Inventory"

		var/products[0]
		for(var/item/itemtemplate/I in shop_area.items_prices)
			products[++products.len] = list("name" = I.name, "price" = I.price, "item" = I.item_id)

		data["products"] = products
	else if(mode == 3) // Check-out screen
		data["text"] = "Check-out"
		data["has_products"] = transaction_items.len

		var/products[0]
		for(var/item/itemtemplate/I in transaction_items)
			products[++products.len] = list("name" = I.name, "price" = I.price, "item" = I.item_id)

		data["products"] = products
		data["subtotal"] = transaction_total
		data["tax"] = tax
		data["tax_total"] = round(tax / 100 * transaction_total, 1)
		var/total_to_pay = transaction_total + round(tax / 100 * transaction_total, 1)
		data["total"] = total_to_pay
		data["change_given"] = transaction_paid
		var/change_to_return = transaction_paid - total_to_pay
		if(change_to_return >= 0)
			data["change_to_return"] = "CHANGE TO RETURN: T[change_to_return]"
		else
			data["change_to_return"] = "NOT ENOUGH PAID"

	else if(mode == 4)
		data["text"] = "Settings"
	else if(mode == 5)
		data["text"] = "Clean prices list confirmation"
	else if(mode == 6)
		data["text"] = "Cash"

		var/thalers_list[0]
		for(var/item/thaler/T in thalers)
			thalers_list[++thalers_list.len] = list("worth" = T.worth, "amount" = T.amount)
		data["thalers"] = thalers_list
	else if(mode == 7)
		data["text"] = "Transactions"
		var/transactions_list[0]
		for(var/item/shop_transaction/st in shop_area.transactions_list)
			transactions_list[++transactions_list.len] = list("name" = st.name, "id" = st.id)
		data["transactions"] = transactions_list
	else if(mode == 8)
		var/item/shop_transaction/s
		for (var/item/shop_transaction/ST in shop_area.transactions_list)
			if("[ST.id]" == "[selected_transaction]")
				s = ST
		data["text"] = "Transaction [s.name]"
		var/items_list[0]
		for(var/item/itemtemplate/I in s.items)
			items_list[++items_list.len] = list("name" = I.name, "price" = I.price)
		data["items"] = items_list
		data["subtotal"] = s.total_amount
		data["tax"] = s.tax_applied
		data["tax_total"] = round(s.tax_applied / 100 * s.total_amount, 1)
		data["total"] = s.total_amount + round(s.tax_applied / 100 * s.total_amount, 1)
		data["transaction"] = s.id

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
		else if(href_list["option"] == "toggleSettings")
			mode = 4
		else if(href_list["option"] == "clearInventoryQuestion")
			mode = 5
		else if(href_list["option"] == "toggleCash")
			mode = 6
		else if(href_list["option"] == "toggleTransactions")
			mode = 7
		else if(href_list["option"] == "toggleBack")
			if(mode == 8)
				mode = 7
			else if(mode == 7)
				mode = 1
			else if(mode == 6)
				if(transaction_items.len > 0)
					mode = 3
				else
					mode = 1
			else if(mode == 5)
				mode = 4
			else
				mode = 1
		else if(href_list["option"] == "setAccount")
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
		else if(href_list["option"] == "setPOS")
			var/pos_id = (input(user, "Set POS", "POS ID") as null|num)

			for (var/obj/item/weapon/cashregisterpos/pos in cash_register_pos_list)
				if (pos.id == pos_id)
					pos.cash_register = src
					to_chat(user, "POS linked to this cash register.")
		else if(href_list["option"] == "clearInventoryConfirm")
			for(var/item/itemtemplate/I in shop_area.items_prices)
				shop_area.items_prices.Remove(I)
			mode = 3
		else if(href_list["option"] == "printReceipt")
			if(transaction_items.len == 0)
				return TOPIC_HANDLED
			to_chat(user, "*Printing receipt...*")
			return print_receipt()
		else if(href_list["option"] == "objectsPaid")
			var/item/shop_transaction/st = new()
			st.id = ++shop_area.transactions_counter
			st.total_amount = transaction_total
			st.tax_applied = tax
			st.items = transaction_items
			var/prefix = (st.id < 10 ? "#000" : (st.id < 100 ? "#00" : (st.id < 1000 ? "#0" : "#")))
			st.name = "[prefix][st.id]"
			shop_area.transactions_list += st

			for(var/item/itemtemplate/I in transaction_items)
				shop_area.items_prices.Remove(I)
			transaction_items = list()
			transaction_total = 0
			transaction_paid = 0
		else if(href_list["option"] == "deleteCheckOut")
			if(transaction_items.len == 0)
				return TOPIC_HANDLED
			for(var/item/itemtemplate/I in transaction_items)
				shop_area.items_prices.Remove(I)
			transaction_items = list()
			transaction_total = 0
		else if(href_list["option"] == "takescanner")
			toggle_scanner()
		else if(href_list["option"] == "takescanner")
			for(var/item/itemtemplate/I in transaction_items)
				if(I.item == href_list["option"]) transaction_items.Remove(I)
		else if(href_list["option"] == "test") // For testing purposes
			to_chat(user, "Creating...")
			var/area/shop/s = new()
			s.institution_name = "David's Veggies"
			to_chat(user, "Created [s.id]")
			shop_areas_list += s
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
			if("[T.worth]" == "[thaler_value]")
				T.amount--
				spawn_money(T.worth, src.loc, user)
	else if(href_list["PC_shutdown"])
		mode = 0
	else if(href_list["viewTransaction"])
		selected_transaction = href_list["viewTransaction"]
		mode = 8
	else if(href_list["printTransaction"])
		to_chat(user, "*Printing transaction...*")
		return print_transaction(href_list["printTransaction"])

	return TOPIC_REFRESH

// Print receipt
/obj/machinery/cashregister/proc/print_receipt()
	// Create paper
	var/obj/item/weapon/paper/R = new(src.loc)
	R.SetName("Receipt")

	// Ticket text
	R.info += "<b>[shop_area.institution_name]</b><br><br>"
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

// Print transaction
/obj/machinery/cashregister/proc/print_transaction(var/st_id)
	// Get transaction
	var/item/shop_transaction/ST
	for (var/item/shop_transaction/s in shop_area.transactions_list)
		if("[s.id]" == "[st_id]")
			ST = s

	// Create paper
	var/obj/item/weapon/paper/R = new(src.loc)
	R.SetName("Transaction [ST.name]")

	//Temptative new manual:
	R.info += "<b>[shop_area.institution_name] [ST.name]</b><br><br>"
	for(var/item/itemtemplate/I in ST.items)
		R.info += "- [I.name] (T[I.price])<br>"
	R.info += ""
	R.info += "<br>SUBTOTAL: T[ST.total_amount]<br>"
	R.info += "<br>TAX ([ST.tax_applied]): T[round(ST.tax_applied / 100 * ST.total_amount, 1)]<br>"
	R.info += "<br>TOTAL: T[ST.total_amount + round(ST.tax_applied / 100 * ST.total_amount, 1)]<br>"

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

// Pay with card
/obj/machinery/cashregister/proc/pay_with_card(obj/item/device/W, mob/user)
	if(transaction_total > 0)
		var/obj/item/weapon/card/id/idcard = W
		var/datum/money_account/D = get_account(idcard.associated_account_number)
		if(D)
			var/amount_to_pay = transaction_total + round(tax / 100 * transaction_total, 1)
			if(D.money >= amount_to_pay)
				D.withdraw(amount_to_pay, "Purchase at [shop_area.institution_name]", shop_area.institution_name)
				var/item/shop_transaction/st = new()
				st.id = ++shop_area.transactions_counter
				st.total_amount = transaction_total
				st.tax_applied = tax
				st.items = transaction_items
				var/prefix = (st.id < 10 ? "#000" : (st.id < 100 ? "#00" : (st.id < 1000 ? "#0" : "#")))
				st.name = "[prefix][st.id]"
				shop_area.transactions_list += st

				for(var/item/itemtemplate/I in transaction_items)
					shop_area.items_prices.Remove(I)
				transaction_items = list()
				transaction_total = 0
				transaction_paid = 0
				to_chat(user, "*Beep*")
			else
				to_chat(user, "Not enough money.")
		else
			to_chat(user, "Error. No account found.")
	else
		to_chat(user, "It seems like there's nothing to pay for.")

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