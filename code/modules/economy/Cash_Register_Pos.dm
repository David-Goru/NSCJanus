var/cash_register_pos_counter = 0
var/cash_register_pos_list = list()

// Define cash register POS
/obj/machinery/cashregisterpos
	name = "\improper Cash register POS"
	desc = "Cash register POS description"
	icon = 'icons/obj/cashregister.dmi'
	icon_state = "pos"

	density = 0
	anchored = 1
	dir = 4
	idle_power_usage = 10
	active_power_usage = 20

	var/panel_state = 0 // 0 for closed, 1 for open
	var/obj/machinery/cashregister/cash_register = null
	var/id

/obj/machinery/cashregisterpos/New()
	id = ++cash_register_pos_counter
	cash_register_pos_list += src

// When POS is clicked with something on hand
/obj/machinery/cashregisterpos/attackby(obj/item/device/W, mob/user, params)
	if((obj_flags & OBJ_FLAG_ANCHORABLE) && isWrench(W))
		wrench_floor_bolts(user)
		return
	else if(isScrewdriver(W))
		panel_state = !panel_state
		if (panel_state)
			to_chat(user, "The POS panel is now open.")
		else
			to_chat(user, "The POS is now closed.")
	else if(isMultitool(W) && panel_state == 1)
		to_chat(user, "POS ID is [id]")
	else if(istype(W, /obj/item/weapon/card))
		if(cash_register)
			cash_register.pay_with_card(W, user)
		else
			to_chat(user, "The POS is not connected to any cash register.")
	else
		return ..()