/datum/tooltip
	var/client/owner
	var/control = "mainwindow.tooltip"
	var/showing = 0
	var/init = 0


/datum/tooltip/New(client/C)
	if (C)
		owner = C
	..()


/datum/tooltip/proc/show(atom/movable/thing, params = null, title = null, content = null, theme = "default", special = "none")
	if (!thing || !params || (!title && !content) || !owner || !isnum(world.icon_size))
		return 0
	if (!init)
		//Initialize some vars
		init = 1
		owner << output(list2params(list(world.icon_size, control)), "[control]:tooltip.init")

	showing = 1

	if (title && content)
		title = "<h1>[title]</h1>"
		content = "<p>[content]</p>"
	else if (title && !content)
		title = "<p>[title]</p>"
	else if (!title && content)
		content = "<p>[content]</p>"

	// Strip macros from item names
	title = replacetext(title, "\proper", "")
	title = replacetext(title, "\improper", "")

	//Make our dumb param object
	if(params[1] != "i") //Byond Bug: http://www.byond.com/forum/?post=2352648
		params = "icon-x=16;icon-y=16;[params]" //Put in some placeholders
	params = {"{ "cursor": "[params]", "screenLoc": "[thing.screen_loc]" }"}

	//Send stuff to the tooltip
	var/view_size = getviewsize(owner.view)
	owner << output(list2params(list(params, view_size[1] , view_size[2], "[title][content]", theme, special)), "[control]:tooltip.update")

	//If a hide() was hit while we were showing, run hide() again to avoid stuck tooltips
	showing = 0

	return 1

/datum/tooltip/proc/hide()
	winshow(owner, control, FALSE)

//Open a tooltip for user, at a location based on params
//Includes sanity checks.
/proc/openToolTip(mob/user = null, atom/movable/tip_src = null, params = null, title = "", content = "", theme = "")
	if(istype(user))
		if(user.client && user.client.tooltips)
			user.client.tooltips.show(tip_src, params, title, content, "midnight")


//Arbitrarily close a user's tooltip
//Includes sanity checks.
/proc/closeToolTip(mob/user)
	if(istype(user))
		if(user.client && user.client.tooltips)
			user.client.tooltips.hide()