/obj/var/list/req_access = list()

// Returns 1 if this mob has sufficient access to use this object
/atom/movable/proc/allowed(mob/M)
	// Check if it doesn't require any access at all
	if(src.check_access(null))
		return TRUE
	if(!istype(M))
		return FALSE
	return check_access_list(M.GetAccess())

/atom/movable/proc/GetAccess()
	. = list()
	var/obj/item/weapon/card/id/id = GetIdCard()
	if(id)
		. += id.GetAccess()

/atom/movable/proc/GetIdCard()
	return null

/atom/movable/proc/check_access(atom/movable/A)
	return check_access_list(A ? A.GetAccess() : list())

/atom/movable/proc/check_access_list(list/L)
	var/list/R = get_req_access()

	if(!R)
		R = list()
	if(!istype(L, /list))
		return FALSE

	if(maint_all_access)
		L = L.Copy()
		L |= access_command

	return has_access(R, L)

/proc/has_access(list/req_access, list/accesses)
	for(var/req in req_access)
		if(islist(req))
			var/found = FALSE
			for(var/req_one in req)
				if(req_one in accesses)
					found = TRUE
					break
			if(!found)
				return FALSE
		else if(!(req in accesses)) // Doesn't have this access
			return FALSE
	return TRUE

// Checks if the access (constant or list) is contained in one of the entries of access_patterns, a list of lists.
/proc/has_access_pattern(list/access_patterns, access)
	if(!islist(access))
		access = list(access)
	for(var/access_pattern in access_patterns)
		if(has_access(access_pattern, access))
			return 1

// Used for retrieving required access information, if available
/atom/movable/proc/get_req_access()
	return null

/obj/get_req_access()
	return req_access

/var/list/datum/access/priv_all_access_datums
/proc/get_all_access_datums()
	if(!priv_all_access_datums)
		priv_all_access_datums = init_subtypes(/datum/access)
		priv_all_access_datums = dd_sortedObjectList(priv_all_access_datums)

	return priv_all_access_datums.Copy()

/var/list/datum/access/priv_all_access_datums_id
/proc/get_all_access_datums_by_id()
	if(!priv_all_access_datums_id)
		priv_all_access_datums_id = list()
		for(var/datum/access/A in get_all_access_datums())
			priv_all_access_datums_id["[A.id]"] = A

	return priv_all_access_datums_id.Copy()

/var/list/datum/access/priv_all_access_datums_region
/proc/get_all_access_datums_by_region()
	if(!priv_all_access_datums_region)
		priv_all_access_datums_region = list()
		for(var/datum/access/A in get_all_access_datums())
			if(!priv_all_access_datums_region[A.region])
				priv_all_access_datums_region[A.region] = list()
			priv_all_access_datums_region[A.region] += A

	return priv_all_access_datums_region.Copy()

///proc/get_access_ids(var/access_types = ACCESS_TYPE_ALL)
//	var/list/L = new()
//	for(var/datum/access/A in get_all_access_datums())
//		if(A.access_type & access_types)
//			L += A.id
//	return L

/*/var/list/priv_all_access
/proc/get_all_accesses()
	if(!priv_all_access)
		priv_all_access = get_access_ids()

	return priv_all_access.Copy()*/

/*/var/list/priv_region_access
/proc/get_region_accesses(var/code)
	if(code == ACCESS_REGION_ALL)
		return get_all_station_access()

	if(!priv_region_access)
		priv_region_access = list()
		for(var/datum/access/A in get_all_access_datums())
			if(!priv_region_access["[A.region]"])
				priv_region_access["[A.region]"] = list()
			priv_region_access["[A.region]"] += A.id

	var/list/region = priv_region_access["[code]"]
	return region.Copy()*/

/proc/get_region_accesses_name(var/code)
	switch(code)
		if(ACCESS_REGION_ALL)
			return "All"
		if(ACCESS_REGION_BANK)
			return "Bank"
		if(ACCESS_REGION_NANOTRASEN)
			return "Nanotrasen"
		if(ACCESS_REGION_CIVILIAN)
			return "Civilian"

/proc/get_access_desc(id)
	var/list/AS = priv_all_access_datums_id || get_all_access_datums_by_id()
	var/datum/access/A = AS["[id]"]

	return A ? A.desc : ""

/proc/get_access_by_id(id)
	var/list/AS = priv_all_access_datums_id || get_all_access_datums_by_id()
	return AS[id]

/mob/observer/ghost
	var/static/obj/item/weapon/card/id/all_access/ghost_all_access

/mob/observer/ghost/GetIdCard()
	if(!is_admin(src))
		return

	if(!ghost_all_access)
		ghost_all_access = new()
	return ghost_all_access

/mob/living/bot/GetIdCard()
	return botcard

#define HUMAN_ID_CARDS list(get_active_hand(), wear_id, get_inactive_hand())
/mob/living/carbon/human/GetIdCard()
	for(var/item_slot in HUMAN_ID_CARDS)
		var/obj/item/I = item_slot
		var/obj/item/weapon/card/id = I ? I.GetIdCard() : null
		if(id)
			return id
	var/obj/item/organ/internal/controller/controller = locate() in internal_organs
	if(istype(controller))
		return controller.GetIdCard()

/mob/living/carbon/human/GetAccess()
	. = list()
	for(var/item_slot in HUMAN_ID_CARDS)
		var/obj/item/I = item_slot
		if(I)
			. |= I.GetAccess()
	var/obj/item/organ/internal/controller/controller = locate() in internal_organs
	if(istype(controller))
		. |= controller.GetAccess()
#undef HUMAN_ID_CARDS

/mob/living/silicon/GetIdCard()
	if(stat || (ckey && !client))
		return // Unconscious, dead or once possessed but now client-less silicons are not considered to have id access.
	return idcard

/proc/FindNameFromID(var/mob/M, var/missing_id_name = "Unknown")
	var/obj/item/weapon/card/id/C = M.GetIdCard()
	if(C)
		return C.registered_name
	return missing_id_name

/proc/get_all_job_icons() // For all existing HUD icons
	return SSjobs.titles_to_datums + list("Prisoner")

/obj/proc/GetJobName() // Used in secHUD icon generation
	var/obj/item/weapon/card/id/I = GetIdCard()

	if(I)
		var/job_icons = get_all_job_icons()
		if(I.assignment	in job_icons) // Check if the job has a hud icon
			return I.assignment
		if(I.rank in job_icons)
			return I.rank
	else
		return

	return "Unknown" // Return unknown if none of the above apply

/proc/get_access_region_by_id(id)
	var/datum/access/AD = get_access_by_id(id)
	return AD.region