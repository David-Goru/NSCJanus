/decl/hierarchy/outfit/job/janus/crew/command
	name = OUTFIT_JOB_NAME("janus Command Outfit")
	hierarchy_type = /decl/hierarchy/outfit/job/janus/crew/command
	l_ear = /obj/item/device/radio/headset/headset_com

/decl/hierarchy/outfit/job/janus/crew/command/CO
	name = OUTFIT_JOB_NAME("Commanding Officer")
	glasses = /obj/item/clothing/glasses/sunglasses
	uniform = /obj/item/clothing/under/solgov/utility/expeditionary/officer/command
	l_ear = /obj/item/device/radio/headset/heads/janusexec
	shoes = /obj/item/clothing/shoes/dutyboots
	head = /obj/item/clothing/head/soft/solgov/expedition/co
	id_type = /obj/item/weapon/card/id/janus/gold
	pda_type = /obj/item/modular_computer/pda/captain

/decl/hierarchy/outfit/job/janus/crew/command/CO/New()
	..()
	backpack_overrides[/decl/backpack_outfit/backpack] = /obj/item/weapon/storage/backpack/captain
	backpack_overrides[/decl/backpack_outfit/satchel] = /obj/item/weapon/storage/backpack/satchel/cap
	backpack_overrides[/decl/backpack_outfit/messenger_bag] = /obj/item/weapon/storage/backpack/messenger/com

/decl/hierarchy/outfit/job/janus/crew/command/XO
	name = OUTFIT_JOB_NAME("Executive Officer")
	uniform = /obj/item/clothing/under/solgov/utility/expeditionary/officer/command
	l_ear = /obj/item/device/radio/headset/heads/janusexec
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/janus/silver
	pda_type = /obj/item/modular_computer/pda/heads/hop

/decl/hierarchy/outfit/job/janus/crew/command/XO/fleet
	name = OUTFIT_JOB_NAME("Executive Officer - Fleet")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/command
	shoes = /obj/item/clothing/shoes/dutyboots

/decl/hierarchy/outfit/job/janus/crew/command/cmo
	name = OUTFIT_JOB_NAME("Chief Medical Officer - janus")
	l_ear  =/obj/item/device/radio/headset/heads/cmo
	uniform = /obj/item/clothing/under/solgov/utility/expeditionary/officer/medical
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/janus/silver/medical
	pda_type = /obj/item/modular_computer/pda/heads/cmo
	pda_slot = slot_l_store

/decl/hierarchy/outfit/job/janus/crew/command/cmo/New()
	..()
	BACKPACK_OVERRIDE_MEDICAL

/decl/hierarchy/outfit/job/janus/crew/command/cmo/fleet
	name = OUTFIT_JOB_NAME("Chief Medical Officer - Fleet")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/medical
	shoes = /obj/item/clothing/shoes/dutyboots

/decl/hierarchy/outfit/job/janus/crew/command/chief_engineer
	name = OUTFIT_JOB_NAME("Chief Engineer - janus")
	uniform = /obj/item/clothing/under/solgov/utility/expeditionary/officer/engineering
	shoes = /obj/item/clothing/shoes/dutyboots
	l_ear = /obj/item/device/radio/headset/heads/ce
	id_type = /obj/item/weapon/card/id/janus/silver/engineering
	pda_type = /obj/item/modular_computer/pda/heads/ce
	pda_slot = slot_l_store
	flags = OUTFIT_HAS_BACKPACK|OUTFIT_EXTENDED_SURVIVAL

/decl/hierarchy/outfit/job/janus/crew/command/chief_engineer/New()
	..()
	BACKPACK_OVERRIDE_ENGINEERING

/decl/hierarchy/outfit/job/janus/crew/command/chief_engineer/fleet
	name = OUTFIT_JOB_NAME("Chief Engineer - Fleet")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/engineering
	shoes = /obj/item/clothing/shoes/dutyboots

/decl/hierarchy/outfit/job/janus/crew/command/cos
	name = OUTFIT_JOB_NAME("Chief of Security")
	l_ear = /obj/item/device/radio/headset/heads/cos
	uniform = /obj/item/clothing/under/solgov/utility/expeditionary/officer/security
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/janus/silver/security
	pda_type = /obj/item/modular_computer/pda/heads/hos

/decl/hierarchy/outfit/job/janus/crew/command/cos/New()
	..()
	BACKPACK_OVERRIDE_SECURITY

/decl/hierarchy/outfit/job/janus/crew/command/cos/fleet
	name = OUTFIT_JOB_NAME("Chief of Security - Fleet")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/combat/security
	shoes = /obj/item/clothing/shoes/dutyboots

/decl/hierarchy/outfit/job/janus/passenger/workplace_liaison
	name = OUTFIT_JOB_NAME("Workplace Liaison")
	l_ear = /obj/item/device/radio/headset/heads/janusntcommand
	uniform = /obj/item/clothing/under/suit_jacket/corp
	shoes = /obj/item/clothing/shoes/laceup
	id_type = /obj/item/weapon/card/id/janus/passenger/corporate/liaison
	pda_type = /obj/item/modular_computer/pda/heads/paperpusher
	backpack_contents = list(/obj/item/clothing/accessory/badge/nanotrasen = 1)

/decl/hierarchy/outfit/job/janus/passenger/corporate_bodyguard
	name = OUTFIT_JOB_NAME("Loss Prevention Associate")
	l_ear =    /obj/item/device/radio/headset/heads/januscorp
	uniform =  /obj/item/clothing/under/suit_jacket/corp
	shoes =    /obj/item/clothing/shoes/laceup
	id_type =  /obj/item/weapon/card/id/janus/passenger/corporate
	pda_type = /obj/item/modular_computer/pda/heads/paperpusher

/decl/hierarchy/outfit/job/janus/passenger/corporate_bodyguard/union
	name = OUTFIT_JOB_NAME("Union Enforcer")
	l_pocket = /obj/item/clothing/mask/smokable/cigarette/cigar/cohiba
	r_pocket = /obj/item/weapon/flame/lighter/zippo

/decl/hierarchy/outfit/job/janus/passenger/workplace_liaison/union_rep
	name = OUTFIT_JOB_NAME("Union Representative")
	l_pocket = /obj/item/clothing/mask/smokable/cigarette/cigar/cohiba
	r_pocket = /obj/item/weapon/flame/lighter/zippo

/decl/hierarchy/outfit/job/janus/crew/representative
	name = OUTFIT_JOB_NAME("SolGov Representative")
	l_ear = /obj/item/device/radio/headset/headset_com
	uniform = /obj/item/clothing/under/rank/internalaffairs/plain/solgov
	suit = /obj/item/clothing/suit/storage/toggle/suit/black
	shoes = /obj/item/clothing/shoes/laceup
	id_type = /obj/item/weapon/card/id/janus/crew/representative
	pda_type = /obj/item/modular_computer/pda/heads/paperpusher

/decl/hierarchy/outfit/job/janus/crew/command/sea/fleet
	name = OUTFIT_JOB_NAME("Senior Enlisted Advisor - Fleet")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/command
	shoes = /obj/item/clothing/shoes/dutyboots
	l_ear = /obj/item/device/radio/headset/sea
	id_type = /obj/item/weapon/card/id/janus/crew/sea
	pda_type = /obj/item/modular_computer/pda/heads

/decl/hierarchy/outfit/job/janus/crew/command/bridgeofficer
	name = OUTFIT_JOB_NAME("Bridge Officer")
	uniform = /obj/item/clothing/under/solgov/utility/expeditionary/officer/command
	shoes = /obj/item/clothing/shoes/dutyboots
	id_type = /obj/item/weapon/card/id/janus/crew/bridgeofficer
	pda_type = /obj/item/modular_computer/pda/heads
	l_ear = /obj/item/device/radio/headset/bridgeofficer

/decl/hierarchy/outfit/job/janus/crew/command/bridgeofficer/fleet
	name = OUTFIT_JOB_NAME("Bridge Officer - Fleet")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/command
	shoes = /obj/item/clothing/shoes/dutyboots