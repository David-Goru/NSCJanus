/decl/hierarchy/outfit/job/janus/passenger/research
	hierarchy_type = /decl/hierarchy/outfit/job/janus/passenger/research
	l_ear = /obj/item/device/radio/headset/janusnanotrasen

/decl/hierarchy/outfit/job/janus/passenger/research/nt_pilot //pending better uniform
	name = OUTFIT_JOB_NAME("Corporate Pilot")
	uniform = /obj/item/clothing/under/rank/ntpilot
	suit = /obj/item/clothing/suit/storage/toggle/brown_jacket/nanotrasen
	shoes = /obj/item/clothing/shoes/workboots
	l_ear = /obj/item/device/radio/headset/headset_pilot
	id_type = /obj/item/weapon/card/id/janus/passenger/research/nt_pilot

/decl/hierarchy/outfit/job/janus/passenger/research/scientist
	name = OUTFIT_JOB_NAME("Scientist - janus")
	uniform = /obj/item/clothing/under/rank/scientist
	shoes = /obj/item/clothing/shoes/white
	pda_type = /obj/item/modular_computer/pda/science
	id_type = /obj/item/weapon/card/id/janus/passenger/research/scientist

/decl/hierarchy/outfit/job/janus/passenger/research/scientist/New()
	..()
	BACKPACK_OVERRIDE_RESEARCH

/decl/hierarchy/outfit/job/janus/passenger/research/assist
	name = OUTFIT_JOB_NAME("Research Assistant - janus")
	uniform = /obj/item/clothing/under/rank/scientist
	shoes = /obj/item/clothing/shoes/white
	pda_type = /obj/item/modular_computer/pda/science
	id_type = /obj/item/weapon/card/id/janus/passenger/research

/decl/hierarchy/outfit/job/janus/passenger/research/assist/testsubject
	name = OUTFIT_JOB_NAME("Testing Assistant")
	uniform = /obj/item/clothing/under/rank/ntwork