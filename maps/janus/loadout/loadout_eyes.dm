/datum/gear/eyes/eyepatch
	allowed_branches = CIVILIAN_BRANCHES

/datum/gear/eyes/fashionglasses
	allowed_branches = CIVILIAN_BRANCHES

/datum/gear/eyes/sciencegoggles/New()
	allowed_roles = RESEARCH_ROLES | EXPLORATION_ROLES
	..()

/datum/gear/eyes/security
	allowed_roles = SECURITY_ROLES

/datum/gear/eyes/medical
	allowed_roles = MEDICAL_ROLES

/datum/gear/eyes/meson
	allowed_roles = list()

/datum/gear/eyes/welding
	allowed_roles = TECHNICAL_ROLES

/datum/gear/eyes/material
	allowed_roles = list()