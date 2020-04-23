// Define cash register alarm object
/obj/machinery/cashregisteralarm
	name = "\improper Cash register alarm"
	desc = "Cash alarm register description"
	icon = 'icons/obj/cashregister.dmi'
	icon_state = "alarm"

	density = 0
	anchored = 1
	dir = 4
	idle_power_usage = 10
	active_power_usage = 20

	var/panel_state = 0 // 0 for closed, 1 for open
	var/area/shop/shop_area = null

// Check if player bumped has stolen
/obj/machinery/cashregisteralarm/Bumped(atom/movable/A)
	if(shop_area == null) return
	var/mob/M = A
	if(world.time - M.last_bumped <= 10) return	// Check player one time per second (to prevent spam)

	M.last_bumped = world.time
	var/hasstolen = 0

	for(var/item/itemtemplate/I in shop_area.items_prices)
		if(I.item in M.contents)
			hasstolen = 1

	if (hasstolen)
		playsound(A.loc, 'sound/machines/signal.ogg', 50, 1)
		to_chat(A, "*Beep beep beep beep beep*")
		flick("alarm_enabled", src)
	return

// When alarmr is clicked with something on hand
/obj/machinery/cashregisteralarm/attackby(obj/item/device/W, mob/user, params)
	if((obj_flags & OBJ_FLAG_ANCHORABLE) && isWrench(W))
		wrench_floor_bolts(user)
		return
	else if(isScrewdriver(W))
		panel_state = !panel_state
		if (panel_state)
			to_chat(user, "The alarm panel is now open.")
		else
			to_chat(user, "The alarm panel is now closed.")
	else if(isMultitool(W) && panel_state == 1)
		var/shop_id = (input(user,"Shop ID","Set shop ID","") as null|num)
		for(var/area/shop/s in shop_areas_list)
			if(s.id == shop_id)
				shop_area = s
				to_chat(user, "Cash register alarm linked to shop with ID [shop_id]")
	else
		return ..()